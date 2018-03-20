defmodule GQLardianWeb.Resolvers.Auth do
  alias GQLardian.Auth
  alias GQLardian.Auth.Guardian

  require Logger

  def login(_, %{username: username, password: password}, _) do
    with {:ok, user} <- Auth.authenticate(username, password),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{user: user, token: token}}
    else
      {:error, reason} when reason in [:not_found, :password_mismatch] ->
        {:error, "invalid username/password combination"}

      {:error, reason} ->
        Logger.error("Guardian failed encoding and signing user #{username} with error #{reason}")
        {:error, "Ooops! Something went wrong"}
    end
  end
end
