defmodule Hpd.Seeds do
  def clean_fields(fields) do
    fields |> Enum.map(fn f -> String.trim(f) |> String.replace(".", "_")  end)
  end
    
  def map_fields(fields, data_row) do
    fields
    |> Enum.with_index()
    |> Enum.map(fn {f, i} -> {f, Enum.at(data_row, i)} end)
    |> Enum.into(%{})
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
end

