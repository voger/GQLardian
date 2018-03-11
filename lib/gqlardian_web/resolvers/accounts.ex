defmodule GQLardianWeb.Resolvers.Accounts do
  alias GQLardian.Accounts

  def get_user(_, %{id: id}, _res) do
    {:ok, Accounts.get_user(id)}
  end

  def create_user(_, %{input: arguments}, _res) do
    with {:ok, %Accounts.User{} = user} <- Accounts.create_user(arguments) do
      {:ok, user}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:ok, changeset}
    end
  end
end
