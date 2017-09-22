defmodule Hpd.SystemControllerTest do
  use Hpd.ConnCase

  alias Hpd.System
  @valid_attrs %{nodes_cpuAvgMax: 42, osVersion: "some osVersion", disksState: "some disksState", performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis: 120.5, capacity_byType_fc_freeTiB: 120.5, performance_summary_portInfo_totalServiceTimeMillis: 120.5, serialNumber: 42, capacity_total_sizeTiB: 120.5, performance_portBandwidthData_total_iopsAvg: 42, performance_summary_portInfo_readServiceTimeMillis: 120.5, performance_portBandwidthData_total_dataRateKBPSAvg: 120.5, disks_total_diskCount: 42, performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS: 120.5, capacity_total_freePct: 120.5, capacity_total_compressionRatio: 120.5, nodes_nodeCountOffline: 42, capacity_total_freeTiB: 120.5, capacity_byType_ssd_freeTiB: 120.5, performance_summary_delAckPct: 120.5, disks_total_diskCountNormal: 42, vvCount: 42, capacity_byType_ssd_sizeTiB: 120.5, companyName: "some companyName", performance_portBandwidthData_total_iopsMax: 120.5, cpgCount: 42, recommended_osVersion: "some recommended_osVersion", nodes_nodeCount: 42, location_country: "some location_country", capacity_byType_fc_sizeTiB: 120.5, disks_total_diskCountFailed: 42, systemName: "some systemName", capacity_byType_nl_sizeTiB: 120.5, installDate: ~N[2010-04-17 14:00:00.000000], performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS: 120.5, productFamily: 42, capacity_total_dedupeRatio: 120.5, capacity_byType_nl_freeTiB: 120.5, performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis: 120.5, updated: ~N[2010-04-17 14:00:00.000000], disks_total_diskCountDegraded: 42, performance_summary_portInfo_writeServiceTimeMillis: 120.5, capacity_total_compactionRatio: 120.5, tpvvCount: 42, location_region: "some location_region", model: "some model"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, system_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    system = Repo.insert! %System{}
    conn = get conn, system_path(conn, :show, system)
    assert json_response(conn, 200)["data"] == %{"id" => system.id,
      "companyName" => system.companyName,
      "systemName" => system.systemName,
      "serialNumber" => system.serialNumber,
      "productFamily" => system.productFamily,
      "model" => system.model,
      "osVersion" => system.osVersion,
      "cpgCount" => system.cpgCount,
      "recommended_osVersion" => system.recommended_osVersion,
      "location_region" => system.location_region,
      "location_country" => system.location_country,
      "installDate" => system.installDate,
      "updated" => system.updated,
      "nodes_nodeCount" => system.nodes_nodeCount,
      "nodes_nodeCountOffline" => system.nodes_nodeCountOffline,
      "disks_total_diskCount" => system.disks_total_diskCount,
      "disks_total_diskCountNormal" => system.disks_total_diskCountNormal,
      "disks_total_diskCountDegraded" => system.disks_total_diskCountDegraded,
      "disks_total_diskCountFailed" => system.disks_total_diskCountFailed,
      "disksState" => system.disksState,
      "vvCount" => system.vvCount,
      "tpvvCount" => system.tpvvCount,
      "capacity_total_freePct" => system.capacity_total_freePct,
      "capacity_total_freeTiB" => system.capacity_total_freeTiB,
      "capacity_byType_fc_freeTiB" => system.capacity_byType_fc_freeTiB,
      "capacity_byType_nl_freeTiB" => system.capacity_byType_nl_freeTiB,
      "capacity_byType_ssd_freeTiB" => system.capacity_byType_ssd_freeTiB,
      "capacity_total_sizeTiB" => system.capacity_total_sizeTiB,
      "capacity_byType_fc_sizeTiB" => system.capacity_byType_fc_sizeTiB,
      "capacity_byType_nl_sizeTiB" => system.capacity_byType_nl_sizeTiB,
      "capacity_byType_ssd_sizeTiB" => system.capacity_byType_ssd_sizeTiB,
      "capacity_total_compactionRatio" => system.capacity_total_compactionRatio,
      "capacity_total_compressionRatio" => system.capacity_total_compressionRatio,
      "capacity_total_dedupeRatio" => system.capacity_total_dedupeRatio,
      "performance_portBandwidthData_total_dataRateKBPSAvg" => system.performance_portBandwidthData_total_dataRateKBPSAvg,
      "performance_portBandwidthData_total_iopsAvg" => system.performance_portBandwidthData_total_iopsAvg,
      "performance_portBandwidthData_total_iopsMax" => system.performance_portBandwidthData_total_iopsMax,
      "performance_summary_portInfo_totalServiceTimeMillis" => system.performance_summary_portInfo_totalServiceTimeMillis,
      "performance_summary_portInfo_readServiceTimeMillis" => system.performance_summary_portInfo_readServiceTimeMillis,
      "performance_summary_portInfo_writeServiceTimeMillis" => system.performance_summary_portInfo_writeServiceTimeMillis,
      "performance_summary_delAckPct" => system.performance_summary_delAckPct,
      "performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS" => system.performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS,
      "performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS" => system.performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS,
      "performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis" => system.performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis,
      "performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis" => system.performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis,
      "nodes_cpuAvgMax" => system.nodes_cpuAvgMax}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, system_path(conn, :show, -1)
    end
  end
end
