defmodule GQLardian.Auth.Guardian do
  use Guardian, otp_app: :gqlardian

  alias GQLardian.{Accounts, Accounts.User}

  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :some_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    {:ok, resource} = Accounts.get_user(id)
    {:ok, resource}
  end

  # def resource_from_claims(_) do
  #   {:error, :reason_for_error}
  # end
end
