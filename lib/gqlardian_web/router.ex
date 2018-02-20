defmodule GQLardianWeb.Router do
  use GQLardianWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GQLardianWeb do
    pipe_through :api
  end
end
