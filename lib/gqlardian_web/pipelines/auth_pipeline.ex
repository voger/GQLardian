defmodule GQLardianWeb.Pipelines.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :gqlardian,
    module: GQLardian.Auth.Guardian,
    error_handler: GQLardianWeb.AuthErrorHandler


  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: false
end
