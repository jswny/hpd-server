defmodule Hpd.ImportTest do
  use ExUnit.Case, async: true
  doctest Hpd.Import
  import ExUnit.CaptureLog
  require Logger
  import Ecto.Query
  alias Hpd.Repo
  alias Hpd.Import
  alias Hpd.System
  import Hpd.TestHelpers

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Hpd.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Hpd.Repo, {:shared, self()})
    end

    :ok
  end

  setup context do
    case context[:test_data_dir] do
      true -> 
        test_data_dir = "test_data"
        File.mkdir(test_data_dir)
        on_exit fn -> File.rm_rf(test_data_dir) end
        [test_data_dir: test_data_dir]
      _ -> :ok
    end
  end

  @tag test_data_dir: true
  test "get_data_files lists all CSV files in the data directory", context do
    file_1 = [context[:test_data_dir], "foo.csv"] |> Path.join()
    file_2 = [context[:test_data_dir], "bar", "baz.csv"] |> Path.join()

    [context[:test_data_dir], "bar"] |> Path.join() |> File.mkdir()
    Enum.each([file_1, file_2], fn f -> File.touch(f) end)

    assert Import.get_data_files(context[:test_data_dir]) == [file_2, file_1]
  end

  @tag test_data_dir: true
  test "decode_file decodes a file to a list of rows", context do
    content = "one,two,three\nfoo,bar,baz"
    path = [context[:test_data_dir], "test.csv"] |> Path.join()
    File.write(path, content)

    expected = [["one", "two", "three"], ["foo", "bar", "baz"]]
    assert Import.decode_file(path) == expected
  end

  test "clean_fields removes whitespace and replaces periods" do
    fields = ["foo   ", "foo.bar", "   foo", " foo.bar.baz "]
    assert Import.clean_fields(fields) == ["foo", "foo_bar", "foo", "foo_bar_baz"]
  end

  test "map_fields maps each field to it's associated data" do
    fields = ["foo", "bar", "baz"]
    data = ["blah", 3.7, 12]
    assert Import.map_fields(fields, data) == %{"foo" => "blah", "bar" => 3.7, "baz" => 12}
  end

  test "clean_data resolves data inconsistencies" do
    data = %{
      "foo" => 11.5,
      "recommended_osVersion" => "",
      "installDate" => "",
      "bar" => "",
      "baz" => "blah"
    }

    expected = %{
      "foo" => 11.5,
      "recommended_osVersion" => "-",
      "installDate" => "2001-01-01T01:01:01Z",
      "bar" => 0,
      "baz" => "blah"
    }

    assert Import.clean_data(data) == expected
  end

  defp system_count(), do: Repo.one(from s in System, select: count(s.id))

  test "insert_system inserts a valid system into the database" do
    count_before = system_count()
    Import.insert_system(valid_system_attrs())
    count_after = system_count()

    assert count_after == (count_before + 1)
  end

  test "insert_system does not insert an invalid system into the database" do
    count_before = system_count()
    assert capture_log(fn -> Import.insert_system(invalid_system_attrs()) end) =~ "Error inserting system!"
    count_after = system_count()

    assert count_after == count_before
  end
end
