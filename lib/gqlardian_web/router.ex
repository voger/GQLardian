defmodule GQLardianWeb.Router do
  use GQLardianWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GQLardianWeb do
    pipe_through :api
  end


  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: GQLardianWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GQLardianWeb.Schema,
      # socket: GQLardianWeb.UserSocket
      interface: :playground
  end
end
