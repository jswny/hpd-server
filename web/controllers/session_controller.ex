defmodule Hpd.SessionController do
  use Hpd.Web, :controller
  import Hpd.Auth
  
  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    case auth_user(username, password) do
      {:ok, token} -> 
        conn
        |> put_status(:created)
        |> render("show.json", [username: username, token: token])
      {:error, status} -> 
        conn
        |> put_status(status)
        |> render(Hpd.ErrorView, "401.json", status: status)
    end
  end
end
