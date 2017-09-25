defmodule Hpd.UserView do
  use Hpd.Web, :view

  def render("user_success.json", %{user: user}) do
    %{data: %{id: user.id, username: user.username}}
  end
end
