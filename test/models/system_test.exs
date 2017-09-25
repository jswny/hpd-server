defmodule Hpd.SystemTest do
  use Hpd.ModelCase
  alias Hpd.System
  import Hpd.TestHelpers

  test "changeset with valid attributes" do
    changeset = System.changeset(%System{}, valid_system_attrs())
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = System.changeset(%System{}, invalid_system_attrs())
    refute changeset.valid?
  end
end
