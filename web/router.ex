defmodule Hpd.Router do
  use Hpd.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Hpd do
    pipe_through :api
  end
end
