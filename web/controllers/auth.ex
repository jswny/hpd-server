defmodule Hpd.Auth do
  @moduledoc """
  Provides user authentication funcitonality via tokens from `Phoenix.Token`.
  """
  
  alias Hpd.Repo
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  @doc """
  Authenticated an `Hpd.User` by a given `username` and `password`.

  ## Return values 
  - `{:ok, token}` if the user is valid.
  - `{:error, :unauthorized}` if the provided password is incorrect.
  - `{:error, :not_found}` if the user does not exist.
  """
  def auth_user(username, password) do
    user = Repo.get_by(Hpd.User, username: username)

    cond do
      user && checkpw(password, user.password_hash) -> {:ok, generate_token(user.id)}
      user -> {:error, :unauthorized}
      true -> 
        dummy_checkpw()
        {:error, :not_found}
    end
  end

  @doc """
  Generates a valid token for a given `user_id`.

  Uses `Hpd.Endpoint` as the secret and `"user_auth"` for the salt.
  """
  def generate_token(user_id) do
    Phoenix.Token.sign(Hpd.Endpoint, "user auth", user_id)
  end

  @doc """
  Verifies a `token`.

  Uses `Hpd.Endpoint` as the secret and `"user_auth"` for the salt.
  
  ## Return values
  - `{:ok, user_id}` if the token is valid.
  - `{:error, _}` if the token is invalid.
  """
  def verify_token(token) do
    Phoenix.Token.verify(Hpd.Endpoint, "user auth", token, max_age: 86400)
  end
end
