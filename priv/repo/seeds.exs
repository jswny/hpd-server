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

alias Hpd.Repo
alias Hpd.System
alias Hpd.Seeds

defmodule Hpd.Seeds do
  def clean_fields(fields) do
    fields |> Enum.map(fn f -> String.trim(f) |> String.replace(".", "_")  end)
  end
    
  def clean_data(data) do
    data 
    |> Enum.map(fn 
        {"recommended_osVersion", ""} -> {"recommended_osVersion", "-"}
        {"installDate", ""} -> {"installDate", "2001-01-01T01:01:01Z"}
        {k, ""} -> {k, 0}
        {k, v} -> {k, v}
      end)
    |> Enum.into(%{})
  end

  def map_fields(fields, data_row) do
    fields
    |> Enum.with_index()
    |> Enum.map(fn {f, i} -> {f, Enum.at(data_row, i)} end)
    |> Enum.into(%{})
  end
end

data_files = 
  ["data", "**", "*.csv"]
  |> Path.join()
  |> Path.wildcard()

for file <- data_files do
  [fields | data]  = 
    file
    |> File.stream!() 
    |> CSV.decode!() 
    |> Enum.to_list()

  fields = Seeds.clean_fields(fields)

  Enum.each(data, fn r ->
    mapping = Seeds.map_fields(fields, r) |> Seeds.clean_data()
    changeset = System.changeset(%System{}, mapping)

    case Repo.insert(changeset) do
      {:ok, struct} -> IO.puts("\n Inserted system " <> struct.systemName <> " for company " <> struct.companyName <>".")
      {:error, changeset} -> 
        IO.puts("\n Error inserting the following system:")
        IO.inspect(changeset)
        IO.puts("With the following values:")
        IO.inspect(mapping)
    end
  end)
end


