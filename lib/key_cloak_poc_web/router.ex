defmodule KeyCloakPocWeb.Router do
  use KeyCloakPocWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KeyCloakPocWeb do
    pipe_through :api
  end 
end
