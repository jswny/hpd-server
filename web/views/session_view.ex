defmodule Hpd.SessionView do
  use Hpd.Web, :view

  def render("login_success.json", %{username: username, token: token}) do
    %{data: %{username: username, token: token}}
  end
end
