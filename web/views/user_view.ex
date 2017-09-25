defmodule Hpd.UserView do
  use Hpd.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Hpd.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Hpd.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      password_hash: user.password_hash}
  end
end
