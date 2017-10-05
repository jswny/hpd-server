defmodule Hpd.UserController do
  use Hpd.Web, :controller

  alias Hpd.User

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Hpd.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
