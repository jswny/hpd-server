defmodule Hpd.Router do
  use Hpd.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Hpd do
    pipe_through :api
    resources "/users", UserController, only: [:create] 
    resources "/systems", SystemController, only: [:index, :show] 
    resources "/sessions", SessionController, only: [:create]
  end
end
