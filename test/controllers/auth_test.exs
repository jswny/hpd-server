defmodule Hpd.AuthTest do
  use ExUnit.Case, async: true
  import Hpd.TestHelpers
  alias Hpd.Auth

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Hpd.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Hpd.Repo, {:shared, self()})
    end

    :ok
  end

  test "verify_token verifies a valid token" do
    token = Phoenix.Token.sign(Hpd.Endpoint, "user auth", 1)
    assert Auth.verify_token(token) == {:ok, 1}
  end

  test "verify_token returns an error for an invalid token" do
    token = Phoenix.Token.sign(Hpd.Endpoint, "wrong salt", 1)
    assert {:error, _} = Auth.verify_token(token)
  end

  test "generate_token generates a valid token for a given user ID" do
    token = Auth.generate_token(1)
    assert Auth.verify_token(token) == {:ok, 1}
  end

  test "auth_user returns a valid token for a valid user" do
    user = insert_user(valid_user_attrs())

    assert {:ok, token} = Auth.auth_user(valid_user_attrs().username, valid_user_attrs().password)
    assert Auth.verify_token(token) == {:ok, user.id}
  end
  
  test "auth_user returns an unauthorized error for an unauthorized user" do
    insert_user(valid_user_attrs())
    assert Auth.auth_user(valid_user_attrs().username, "wrong") == {:error, :unauthorized}
  end
  
  test "auth_user returns a not_found error for a non existent user" do
    assert Auth.auth_user(valid_user_attrs().username, valid_user_attrs().password) == {:error, :not_found}
  end
end
