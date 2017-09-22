defmodule Hpd.System do
  use Hpd.Web, :model

  schema "systems" do
    field :companyName, :string
    field :systemName, :string
    field :serialNumber, :integer
    field :productFamily, :integer
    field :model, :string
    field :osVersion, :string
    field :cpgCount, :integer
    field :recommended_osVersion, :string
    field :location_region, :string
    field :location_country, :string
    field :installDate, :naive_datetime
    field :updated, :naive_datetime
    field :nodes_nodeCount, :integer
    field :nodes_nodeCountOffline, :integer
    field :disks_total_diskCount, :integer
    field :disks_total_diskCountNormal, :integer
    field :disks_total_diskCountDegraded, :integer
    field :disks_total_diskCountFailed, :integer
    field :disksState, :string
    field :vvCount, :integer
    field :tpvvCount, :integer
    field :capacity_total_freePct, :float
    field :capacity_total_freeTiB, :float
    field :capacity_byType_fc_freeTiB, :float
    field :capacity_byType_nl_freeTiB, :float
    field :capacity_byType_ssd_freeTiB, :float
    field :capacity_total_sizeTiB, :float
    field :capacity_byType_fc_sizeTiB, :float
    field :capacity_byType_nl_sizeTiB, :float
    field :capacity_byType_ssd_sizeTiB, :float
    field :capacity_total_compactionRatio, :float
    field :capacity_total_compressionRatio, :float
    field :capacity_total_dedupeRatio, :float
    field :performance_portBandwidthData_total_dataRateKBPSAvg, :float
    field :performance_portBandwidthData_total_iopsAvg, :integer
    field :performance_portBandwidthData_total_iopsMax, :float
    field :performance_summary_portInfo_totalServiceTimeMillis, :float
    field :performance_summary_portInfo_readServiceTimeMillis, :float
    field :performance_summary_portInfo_writeServiceTimeMillis, :float
    field :performance_summary_delAckPct, :float
    field :performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS, :float
    field :performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS, :float
    field :performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis, :float
    field :performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis, :float
    field :nodes_cpuAvgMax, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:companyName, :systemName, :serialNumber, :productFamily, :model, :osVersion, :cpgCount, :recommended_osVersion, :location_region, :location_country, :installDate, :updated, :nodes_nodeCount, :nodes_nodeCountOffline, :disks_total_diskCount, :disks_total_diskCountNormal, :disks_total_diskCountDegraded, :disks_total_diskCountFailed, :disksState, :vvCount, :tpvvCount, :capacity_total_freePct, :capacity_total_freeTiB, :capacity_byType_fc_freeTiB, :capacity_byType_nl_freeTiB, :capacity_byType_ssd_freeTiB, :capacity_total_sizeTiB, :capacity_byType_fc_sizeTiB, :capacity_byType_nl_sizeTiB, :capacity_byType_ssd_sizeTiB, :capacity_total_compactionRatio, :capacity_total_compressionRatio, :capacity_total_dedupeRatio, :performance_portBandwidthData_total_dataRateKBPSAvg, :performance_portBandwidthData_total_iopsAvg, :performance_portBandwidthData_total_iopsMax, :performance_summary_portInfo_totalServiceTimeMillis, :performance_summary_portInfo_readServiceTimeMillis, :performance_summary_portInfo_writeServiceTimeMillis, :performance_summary_delAckPct, :performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS, :performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS, :performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis, :performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis, :nodes_cpuAvgMax])
    |> validate_required([:companyName, :systemName, :serialNumber, :productFamily, :model, :osVersion, :cpgCount, :recommended_osVersion, :location_region, :location_country, :installDate, :updated, :nodes_nodeCount, :nodes_nodeCountOffline, :disks_total_diskCount, :disks_total_diskCountNormal, :disks_total_diskCountDegraded, :disks_total_diskCountFailed, :disksState, :vvCount, :tpvvCount, :capacity_total_freePct, :capacity_total_freeTiB, :capacity_byType_fc_freeTiB, :capacity_byType_nl_freeTiB, :capacity_byType_ssd_freeTiB, :capacity_total_sizeTiB, :capacity_byType_fc_sizeTiB, :capacity_byType_nl_sizeTiB, :capacity_byType_ssd_sizeTiB, :capacity_total_compactionRatio, :capacity_total_compressionRatio, :capacity_total_dedupeRatio, :performance_portBandwidthData_total_dataRateKBPSAvg, :performance_portBandwidthData_total_iopsAvg, :performance_portBandwidthData_total_iopsMax, :performance_summary_portInfo_totalServiceTimeMillis, :performance_summary_portInfo_readServiceTimeMillis, :performance_summary_portInfo_writeServiceTimeMillis, :performance_summary_delAckPct, :performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS, :performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS, :performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis, :performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis, :nodes_cpuAvgMax])
  end
end
