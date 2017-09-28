defmodule Hpd.UserTest do
  use Hpd.ModelCase
  alias Hpd.User
  import Hpd.TestHelpers

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, valid_user_attrs())
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, invalid_user_attrs())
    refute changeset.valid?
  end

  test "changeset with valid attributes hashes password" do
    changeset = User.changeset(%User{}, valid_user_attrs())
    %{password: pass, password_hash: pass_hash} = changeset.changes
    assert pass_hash
    assert pass != pass_hash
    assert Comeonin.Bcrypt.checkpw(pass, pass_hash)
  end

  test "converts unique_constraint on username to error" do
    insert_user(valid_user_attrs())

    changeset = User.changeset(%User{}, valid_user_attrs())
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:username, {"has already been taken", []}} in changeset.errors 
  end
end
