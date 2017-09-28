defmodule Hpd.SessionController do
  use Hpd.Web, :controller
  import Hpd.Auth
  
  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case auth_user(username, password) do
      {:ok, token} -> 
        conn
        |> put_status(:created)
        |> render("login_success.json", [username: username, token: token])
      {:error, status} -> 
        conn
        |> put_status(status)
        |> render("login_error.json", [username: username, status: status])
    end
  end
end
