defmodule GQLardian.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias GQLardian.Accounts.User

  require Cl

  schema "users" do
    field :password_hash, Comeonin.Ecto.Password
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    attrs = rename_password_field(attrs)

    user
    |> cast(attrs, [:username, :password_hash])
    |> validate_required([:username, :password_hash])
    |> unique_constraint(:username, message: "already taken")
  end

  defp rename_password_field(%{password: password} = attrs) do
    attrs
    |> Map.put_new(:password_hash, password)
    |> Map.delete(:password)
  end

end
