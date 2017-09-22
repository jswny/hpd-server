defmodule Hpd.Repo.Migrations.CreateSystem do
  use Ecto.Migration

  def change do
    create table(:systems) do
      add :companyName, :string
      add :systemName, :string
      add :serialNumber, :integer
      add :productFamily, :integer
      add :model, :string
      add :osVersion, :string
      add :cpgCount, :integer
      add :recommended_osVersion, :string
      add :location_region, :string
      add :location_country, :string
      add :installDate, :naive_datetime
      add :updated, :naive_datetime
      add :nodes_nodeCount, :integer
      add :nodes_nodeCountOffline, :integer
      add :disks_total_diskCount, :integer
      add :disks_total_diskCountNormal, :integer
      add :disks_total_diskCountDegraded, :integer
      add :disks_total_diskCountFailed, :integer
      add :disksState, :string
      add :vvCount, :integer
      add :tpvvCount, :integer
      add :capacity_total_freePct, :float
      add :capacity_total_freeTiB, :float
      add :capacity_byType_fc_freeTiB, :float
      add :capacity_byType_nl_freeTiB, :float
      add :capacity_byType_ssd_freeTiB, :float
      add :capacity_total_sizeTiB, :float
      add :capacity_byType_fc_sizeTiB, :float
      add :capacity_byType_nl_sizeTiB, :float
      add :capacity_byType_ssd_sizeTiB, :float
      add :capacity_total_compactionRatio, :float
      add :capacity_total_compressionRatio, :float
      add :capacity_total_dedupeRatio, :float
      add :performance_portBandwidthData_total_dataRateKBPSAvg, :float
      add :performance_portBandwidthData_total_iopsAvg, :integer
      add :performance_portBandwidthData_total_iopsMax, :float
      add :performance_summary_portInfo_totalServiceTimeMillis, :float
      add :performance_summary_portInfo_readServiceTimeMillis, :float
      add :performance_summary_portInfo_writeServiceTimeMillis, :float
      add :performance_summary_delAckPct, :float
      add :performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS, :float
      add :performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS, :float
      add :performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis, :float
      add :performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis, :float
      add :nodes_cpuAvgMax, :integer

      timestamps()
    end
  end
end
