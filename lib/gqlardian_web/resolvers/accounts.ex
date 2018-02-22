defmodule GQLardianWeb.Resolvers.Accounts do
  alias GQLardian.Accounts
  require Cl

  def get_user(field, arguments, _res) do
    Cl.inspect(field, label: "-b field")
    Cl.inspect(arguments, label: "-b arguments")

  end
end
