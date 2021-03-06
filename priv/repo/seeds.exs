# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hpd.Repo.insert!(%Hpd.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias Hpd.Import

# Get a list of the data files from the /data directory
data_files = Import.get_data_files()

for file <- data_files do

  # Use the first row of the data file as the list of fields and the rest of the rows as the data
  [fields | data]  = Import.decode_file(file)
  fields = Import.clean_fields(fields)

  Enum.each(data, fn row ->
    fields
    |> Import.map_fields(row) 
    |> Import.clean_data()
    |> Import.insert_system()
  end)
end


