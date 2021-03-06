defmodule Hpd.SystemView do
  use Hpd.Web, :view

  def render("index.json", %{systems: systems}) do
    %{data: render_many(systems, Hpd.SystemView, "system.json")}
  end

  def render("show.json", %{system: system}) do
    %{data: render_one(system, Hpd.SystemView, "system.json")}
  end

  def render("system.json", %{system: system}) do
    %{id: system.id,
      companyName: system.companyName,
      systemName: system.systemName,
      serialNumber: system.serialNumber,
      productFamily: system.productFamily,
      model: system.model,
      osVersion: system.osVersion,
      cpgCount: system.cpgCount,
      recommended_osVersion: system.recommended_osVersion,
      location_region: system.location_region,
      location_country: system.location_country,
      installDate: system.installDate,
      updated: system.updated,
      nodes_nodeCount: system.nodes_nodeCount,
      nodes_nodeCountOffline: system.nodes_nodeCountOffline,
      disks_total_diskCount: system.disks_total_diskCount,
      disks_total_diskCountNormal: system.disks_total_diskCountNormal,
      disks_total_diskCountDegraded: system.disks_total_diskCountDegraded,
      disks_total_diskCountFailed: system.disks_total_diskCountFailed,
      disksState: system.disksState,
      vvCount: system.vvCount,
      tpvvCount: system.tpvvCount,
      capacity_total_freePct: system.capacity_total_freePct,
      capacity_total_freeTiB: system.capacity_total_freeTiB,
      capacity_byType_fc_freeTiB: system.capacity_byType_fc_freeTiB,
      capacity_byType_nl_freeTiB: system.capacity_byType_nl_freeTiB,
      capacity_byType_ssd_freeTiB: system.capacity_byType_ssd_freeTiB,
      capacity_total_sizeTiB: system.capacity_total_sizeTiB,
      capacity_byType_fc_sizeTiB: system.capacity_byType_fc_sizeTiB,
      capacity_byType_nl_sizeTiB: system.capacity_byType_nl_sizeTiB,
      capacity_byType_ssd_sizeTiB: system.capacity_byType_ssd_sizeTiB,
      capacity_total_compactionRatio: system.capacity_total_compactionRatio,
      capacity_total_compressionRatio: system.capacity_total_compressionRatio,
      capacity_total_dedupeRatio: system.capacity_total_dedupeRatio,
      performance_portBandwidthData_total_dataRateKBPSAvg: system.performance_portBandwidthData_total_dataRateKBPSAvg,
      performance_portBandwidthData_total_iopsAvg: system.performance_portBandwidthData_total_iopsAvg,
      performance_portBandwidthData_total_iopsMax: system.performance_portBandwidthData_total_iopsMax,
      performance_summary_portInfo_totalServiceTimeMillis: system.performance_summary_portInfo_totalServiceTimeMillis,
      performance_summary_portInfo_readServiceTimeMillis: system.performance_summary_portInfo_readServiceTimeMillis,
      performance_summary_portInfo_writeServiceTimeMillis: system.performance_summary_portInfo_writeServiceTimeMillis,
      performance_summary_delAckPct: system.performance_summary_delAckPct,
      performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS: system.performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS,
      performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS: system.performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS,
      performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis: system.performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis,
      performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis: system.performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis,
      nodes_cpuAvgMax: system.nodes_cpuAvgMax}
  end
end
