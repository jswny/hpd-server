defmodule Hpd.SeedsTest do
  use ExUnit.Case, async: true
  doctest Hpd.Seeds
  alias Hpd.Seeds

  test "get_data_files lists all CSV files in the data directory" do
    file_1 = ["data_test", "foo.csv"] |> Path.join()
    file_2 = ["data_test", "bar", "baz.csv"] |> Path.join()

    File.mkdir("data_test")
    File.mkdir("data_test/bar")
    Enum.each([file_1, file_2], fn f -> File.touch(f) end)

    assert Seeds.get_data_files("data_test") == [file_2, file_1]

    File.rm_rf("data_test")
  end

  test "clean_fields removes whitespace and replaces periods" do
    fields = ["foo   ", "foo.bar", "   foo", " foo.bar.baz "]
    assert Seeds.clean_fields(fields) == ["foo", "foo_bar", "foo", "foo_bar_baz"]
  end

  test "map_fields maps each field to it's associated data" do
    fields = ["foo", "bar", "baz"]
    data = ["blah", 3.7, 12]
    assert Seeds.map_fields(fields, data) == %{"foo" => "blah", "bar" => 3.7, "baz" => 12}
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

    assert Seeds.clean_data(data) == expected
  end
end
