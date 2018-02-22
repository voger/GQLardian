defmodule GQLardianWeb.Resolvers.Accounts do
  alias GQLardian.Accounts

  def get_user(field, arguments, _res) do
  end

  def create_user(_, %{input: arguments}, _res) do
    with {:ok, %Accounts.User{} = user} <- Accounts.create_user(arguments) do
      {:ok, user}
    else
      error ->
        {:error, "Could not create user"}
    end
  end
end
