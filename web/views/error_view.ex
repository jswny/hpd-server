defmodule Hpd.ErrorView do
  use Hpd.Web, :view

  def render("404.json", _assigns) do
    %{errors: %{detail: "Page not found"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error"}}
  end
  
  def render("401.json", %{status: :not_found}) do
    %{errors: %{detail: "Specified user does not exist"}}
  end
  
  def render("401.json", %{status: :unauthorized}) do
    %{errors: %{detail: "Invalid username or password"}}
  end

  def render("401.json", %{status: :no_token}) do
    %{errors: %{detail: "No token provided"}}
  end

  def render("401.json", %{status: :invalid_token}) do
    %{errors: %{detail: "Invalid token"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end
