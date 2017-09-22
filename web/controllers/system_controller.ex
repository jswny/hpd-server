defmodule Hpd.SystemController do
  use Hpd.Web, :controller

  alias Hpd.System

  def index(conn, _params) do
    systems = Repo.all(System)
    render(conn, "index.json", systems: systems)
  end

  def create(conn, %{"system" => system_params}) do
    changeset = System.changeset(%System{}, system_params)

    case Repo.insert(changeset) do
      {:ok, system} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", system_path(conn, :show, system))
        |> render("show.json", system: system)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Hpd.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    system = Repo.get!(System, id)
    render(conn, "show.json", system: system)
  end

  def update(conn, %{"id" => id, "system" => system_params}) do
    system = Repo.get!(System, id)
    changeset = System.changeset(system, system_params)

    case Repo.update(changeset) do
      {:ok, system} ->
        render(conn, "show.json", system: system)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Hpd.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    system = Repo.get!(System, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(system)

    send_resp(conn, :no_content, "")
  end
end
