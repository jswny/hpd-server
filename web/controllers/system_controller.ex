defmodule Hpd.SystemController do
  use Hpd.Web, :controller

  alias Hpd.System

  def index(conn, _params) do
    systems = Repo.all(System)
    render(conn, "index.json", systems: systems)
  end

  def show(conn, %{"id" => id}) do
    system = Repo.get!(System, id)
    render(conn, "show.json", system: system)
  end
end
