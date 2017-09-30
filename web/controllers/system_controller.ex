defmodule Hpd.SystemController do
  use Hpd.Web, :controller
  alias Hpd.System
  import Hpd.Auth, only: [check_token: 2]

  # Specify that these routes require a valid API token to access
  plug :check_token

  def index(conn, _params) do
    systems = Repo.all(System)
    render(conn, "index.json", systems: systems)
  end

  def show(conn, %{"id" => id}) do
    system = Repo.get!(System, id)
    render(conn, "show.json", system: system)
  end
end
