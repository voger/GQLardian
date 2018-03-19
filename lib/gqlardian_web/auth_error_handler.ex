defmodule GQLardianWeb.AuthErrorHandler do
  import Plug.Conn
  require Cl

  def auth_error(conn, {type, reason}, _opts) do
    
    Cl.inspect({type, reason}, label: "-b {type, reason}")
    body = Poison.encode!(%{message: to_string(type)})
    send_resp(conn, 401, body)
  end
end
