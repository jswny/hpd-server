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
  
 test "converts unique_constraint on system name and company name to error" do
   %System{}
   |> System.changeset(valid_system_attrs())
   |> Repo.insert!()

   changeset = System.changeset(%System{}, valid_system_attrs())
   assert {:error, changeset} = Repo.insert(changeset)
   assert {:systemName, {"has already been taken", []}} in changeset.errors
 end
end
