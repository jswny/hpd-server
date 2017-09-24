defmodule Hpd.ImportTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  doctest Hpd.Import

  import Ecto.Query
  alias Hpd.Repo
  alias Hpd.Import
  alias Hpd.System

  @valid_attrs %{nodes_cpuAvgMax: 42, osVersion: "some osVersion", disksState: "some disksState", performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis: 120.5, capacity_byType_fc_freeTiB: 120.5, performance_summary_portInfo_totalServiceTimeMillis: 120.5, serialNumber: 42, capacity_total_sizeTiB: 120.5, performance_portBandwidthData_total_iopsAvg: 42, performance_summary_portInfo_readServiceTimeMillis: 120.5, performance_portBandwidthData_total_dataRateKBPSAvg: 120.5, disks_total_diskCount: 42, performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS: 120.5, capacity_total_freePct: 120.5, capacity_total_compressionRatio: 120.5, nodes_nodeCountOffline: 42, capacity_total_freeTiB: 120.5, capacity_byType_ssd_freeTiB: 120.5, performance_summary_delAckPct: 120.5, disks_total_diskCountNormal: 42, vvCount: 42, capacity_byType_ssd_sizeTiB: 120.5, companyName: "some companyName", performance_portBandwidthData_total_iopsMax: 120.5, cpgCount: 42, recommended_osVersion: "some recommended_osVersion", nodes_nodeCount: 42, location_country: "some location_country", capacity_byType_fc_sizeTiB: 120.5, disks_total_diskCountFailed: 42, systemName: "some systemName", capacity_byType_nl_sizeTiB: 120.5, installDate: ~N[2010-04-17 14:00:00.000000], performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS: 120.5, productFamily: 42, capacity_total_dedupeRatio: 120.5, capacity_byType_nl_freeTiB: 120.5, performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis: 120.5, updated: ~N[2010-04-17 14:00:00.000000], disks_total_diskCountDegraded: 42, performance_summary_portInfo_writeServiceTimeMillis: 120.5, capacity_total_compactionRatio: 120.5, tpvvCount: 42, location_region: "some location_region", model: "some model"}
  @invalid_attrs %{}

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
    assert assert Import.decode_file(path) == expected
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
    assert capture_io(fn -> Import.insert_system(@valid_attrs) end) =~ "Inserted system some systemName for company some companyName."
    count_after = system_count()

    assert count_after == (count_before + 1)
  end

  test "insert_system does not insert an invalid system into the database" do
    count_before = system_count()
    assert capture_io(fn -> Import.insert_system(@invalid_attrs) end) =~ "Error inserting the following system:"
    count_after = system_count()

    assert count_after == count_before
  end
end
