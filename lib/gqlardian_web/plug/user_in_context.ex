defmodule GQLardianWeb.Plug.UserInContext do
  @moduledoc """
  A plug to load current resource and current token in 
  absinthe's context. This is plug is designed to be used with
  the [guardian 1.0](https://github.com/ueberauth/guardian) library.
  Must be placed after the `Guardian.Plug.LoadResource` module.
  """

  @behaviour Plug
  import Guardian.Plug, only: [current_resource: 1, current_token: 1]

  require Cl
  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    %{}
    |> Map.put(:current_user, current_resource(conn))
    |> Map.put(:current_token, current_token(conn))
  end
end
