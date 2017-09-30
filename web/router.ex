defmodule Hpd.Router do
  use Hpd.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Hpd do
    pipe_through :api
    resources "/users", UserController, only: [:create] 
    post "/systems", SystemController, :show
    post "/systems", SystemController, :index
    resources "/sessions", SessionController, only: [:create]
  end
end
