defmodule Hpd.Auth do
  alias Hpd.Repo
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

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

  def generate_token(user_id) do
    Phoenix.Token.sign(Hpd.Endpoint, "user auth", user_id)
  end

  def verify_token(token) do
    Phoenix.Token.verify(Hpd.Endpoint, "user auth", token, max_age: 86400)
  end
end
