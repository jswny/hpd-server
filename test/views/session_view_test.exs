defmodule Hpd.SessionViewTest do
  use Hpd.ConnCase, async: true
  import Phoenix.View

  setup do
    %{username: "username", token: "abc123"}
  end

  test "render show.json", %{username: username, token: token} do
    assert render(Hpd.SessionView, "show.json", [username: username, token: token]) == %{data: %{username: "username", token: "abc123"}}
  end
  
  test "render session.json", %{username: username, token: token} do
    assert render(Hpd.SessionView, "session.json", [username: username, token: token]) == %{username: "username", token: "abc123"}
  end
end
