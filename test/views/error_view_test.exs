defmodule Hpd.ErrorViewTest do
  use Hpd.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(Hpd.ErrorView, "404.json", []) == %{errors: %{detail: "Page not found"}}
  end

  test "render 500.json" do
    assert render(Hpd.ErrorView, "500.json", []) == %{errors: %{detail: "Internal server error"}}
  end

  test "render 401.json with nonexistent user" do
    assert render(Hpd.ErrorView, "401.json", status: :not_found) == %{errors: %{detail: "Specified user does not exist"}}
  end

  test "render 401.json with unauthorized user" do
    assert render(Hpd.ErrorView, "401.json", status: :unauthorized) == %{errors: %{detail: "Invalid username or password"}}
  end

  test "render 401.json with no token provided" do
    assert render(Hpd.ErrorView, "401.json", status: :no_token) == %{errors: %{detail: "No token provided"}}
  end

  test "render 401.json with invalid token" do
    assert render(Hpd.ErrorView, "401.json", status: :invalid_token) == %{errors: %{detail: "Invalid token"}}
  end
  
  test "render any other" do
    assert render(Hpd.ErrorView, "505.json", []) == %{errors: %{detail: "Internal server error"}}
  end
end
