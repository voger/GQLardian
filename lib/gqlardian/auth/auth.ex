defmodule GQLardian.Auth do
  alias GQLardian.Repo
  alias GQLardian.Accounts.User
  alias Comeonin.Ecto.Password

  def authenticate(username, password) do
    with %User{password_hash: password_hash} = user <- Repo.get_by(User, username: username),
         true <- Password.valid?(password, password_hash) do
      {:ok, user}
    else
      nil ->
        {:error, :not_found}
      false ->
        {:error, :password_mismatch}
    end
  end
end
