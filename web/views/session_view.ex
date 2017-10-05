defmodule Hpd.SessionView do
  use Hpd.Web, :view

  def render("show.json", %{username: username, token: token}) do
    %{data: render_one(token, Hpd.SessionView, "session.json", [as: :token, username: username])}
  end

  def render("session.json", %{username: username, token: token}) do
    %{username: username, token: token}
  end
end
