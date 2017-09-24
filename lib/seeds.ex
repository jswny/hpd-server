defmodule Hpd.Seeds do
  @moduledoc """
  Provides functions to facilitate importing CSV data to the database.
  """

  alias Hpd.Repo
  alias Hpd.System

  @doc """
  Gets a list of the CSV data files in the `/data` directory.
  """
  def get_data_files(dir \\ "data") do
    [dir, "**", "*.csv"]
    |> Path.join()
    |> Path.wildcard()
  end

  @doc """
  Decodes a given CSV path to a list of rows.
  """
  def decode_file(path) do
    path
    |> File.stream!() 
    |> CSV.decode!() 
    |> Enum.to_list()
  end

  @doc """
  Cleans a list of fields by trimming them and replacing all periods with underscores.
  """
  def clean_fields(fields) do
    fields |> Enum.map(fn f -> String.trim(f) |> String.replace(".", "_")  end)
  end
    
  @doc """
  Maps a list of `fields` to their corresponding data elements from `data_row`.
  """
  def map_fields(fields, data_row) do
    fields
    |> Enum.with_index()
    |> Enum.map(fn {f, i} -> {f, Enum.at(data_row, i)} end)
    |> Enum.into(%{})
  end

  @doc """
  Cleans given `data` by fixing malformed entries.

  ## Examples
  
      iex> Hpd.Seeds.clean_data %{"recommended_osVersion" => ""}
      %{"recommended_osVersion" => "-"}

      iex> Hpd.Seeds.clean_data %{"installDate" => ""}
      %{"installDate" => "2001-01-01T01:01:01Z"}

      iex> Hpd.Seeds.clean_data %{"foo" => ""}
      %{"foo" => 0}

      iex> Hpd.Seeds.clean_data %{"bar" => "baz"}
      %{"bar" => "baz"}

  """
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

  @doc """
  Inserts a `Hpd.System` given a `map` of fields and corresponding values.
  """
  def insert_system(map) do
    changeset = System.changeset(%System{}, map)

    case Repo.insert(changeset) do
      {:ok, struct} -> IO.puts("\n Inserted system " <> struct.systemName <> " for company " <> struct.companyName <>".")
      {:error, changeset} -> 
        IO.puts("\n Error inserting the following system:")
        IO.inspect(changeset)
        IO.puts("With the following values:")
        IO.inspect(map)
    end
  end
end

