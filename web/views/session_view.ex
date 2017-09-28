defmodule Hpd.SessionView do
  use Hpd.Web, :view

  def render("login_success.json", %{username: username, token: token}) do
    %{data: %{username: username, token: token}}
  end

  def render("login_error.json", %{username: username, status: status}) do
    %{data: %{username: username, status: status}}
  end
end
