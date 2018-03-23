defmodule GQLardian.Auth do
  alias GQLardian.Repo
  alias GQLardian.Accounts.User
  alias GQLardian.Auth.Guardian
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

  def logout(token) do
    case Guardian.revoke(token) do
      {:ok, claims} ->
        {:ok, claims}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
