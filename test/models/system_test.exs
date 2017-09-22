defmodule Hpd.SystemTest do
  use Hpd.ModelCase

  alias Hpd.System

  @valid_attrs %{nodes_cpuAvgMax: 42, osVersion: "some osVersion", disksState: "some disksState", performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis: 120.5, capacity_byType_fc_freeTiB: 120.5, performance_summary_portInfo_totalServiceTimeMillis: 120.5, serialNumber: 42, capacity_total_sizeTiB: 120.5, performance_portBandwidthData_total_iopsAvg: 42, performance_summary_portInfo_readServiceTimeMillis: 120.5, performance_portBandwidthData_total_dataRateKBPSAvg: 120.5, disks_total_diskCount: 42, performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS: 120.5, capacity_total_freePct: 120.5, capacity_total_compressionRatio: 120.5, nodes_nodeCountOffline: 42, capacity_total_freeTiB: 120.5, capacity_byType_ssd_freeTiB: 120.5, performance_summary_delAckPct: 120.5, disks_total_diskCountNormal: 42, vvCount: 42, capacity_byType_ssd_sizeTiB: 120.5, companyName: "some companyName", performance_portBandwidthData_total_iopsMax: 120.5, cpgCount: 42, recommended_osVersion: "some recommended_osVersion", nodes_nodeCount: 42, location_country: "some location_country", capacity_byType_fc_sizeTiB: 120.5, disks_total_diskCountFailed: 42, systemName: "some systemName", capacity_byType_nl_sizeTiB: 120.5, installDate: ~N[2010-04-17 14:00:00.000000], performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS: 120.5, productFamily: 42, capacity_total_dedupeRatio: 120.5, capacity_byType_nl_freeTiB: 120.5, performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis: 120.5, updated: ~N[2010-04-17 14:00:00.000000], disks_total_diskCountDegraded: 42, performance_summary_portInfo_writeServiceTimeMillis: 120.5, capacity_total_compactionRatio: 120.5, tpvvCount: 42, location_region: "some location_region", model: "some model"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = System.changeset(%System{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = System.changeset(%System{}, @invalid_attrs)
    refute changeset.valid?
  end
end