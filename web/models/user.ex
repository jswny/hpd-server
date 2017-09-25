defmodule Hpd.User do
  use Hpd.Web, :model

  schema "users" do
    field :username, :string
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :password_hash])
    |> validate_required([:username, :password_hash])
    |> unique_constraint(:username)
  end
end
