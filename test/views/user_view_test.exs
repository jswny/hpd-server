defmodule Hpd.UserViewTest do
  use Hpd.ConnCase, async: true
  import Phoenix.View

  setup do
    %{user: %{id: 1, username: "username"}}
  end

  test "render show.json", %{user: user} do
    assert render(Hpd.UserView, "show.json", user: user) == %{data: %{id: 1, username: "username"}}
  end
  
  test "render user.json", %{user: user} do
    assert render(Hpd.UserView, "user.json", user: user) == %{id: 1, username: "username"}
  end
end
