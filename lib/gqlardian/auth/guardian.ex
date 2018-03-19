defmodule GQLardian.Auth.Guardian do
  use Guardian, otp_app: :gqlardian

  alias GQLardian.{Accounts, Accounts.User}

  require Cl

  def subject_for_token(%User{id: id}, _claims) do
    Cl.inspect(id, label: "-b inside subject_for_token")
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :some_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    with %User{} = resource <- Accounts.get_user(id) do
      {:ok, resource}
    end
  end

  # def resource_from_claims(_) do
  #   {:error, :reason_for_error}
  # end
end
