defmodule Hpd.SeedsTest do
  use ExUnit.Case, async: true
  alias Hpd.Seeds

  test "clean_fields removes whitespace and replaces periods" do
    fields = ["foo   ", "foo.bar", "   foo", " foo.bar.baz "]
    assert Seeds.clean_fields(fields) == ["foo", "foo_bar", "foo", "foo_bar_baz"]
  end

  test "map_fields maps each field to it's associated data" do
    fields = ["foo", "bar", "baz"]
    data = ["blah", 3.7, 12]
    assert Seeds.map_fields(fields, data) == %{"foo" => "blah", "bar" => 3.7, "baz" => 12}
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

    assert Seeds.clean_data(data) == expected
  end
end
