defmodule GQLardian.EctoTypes.Hashid do
  @behaviour Ecto.Type

  @local_encoder Hashids.new(
                   salt: Application.get_env(:hashids, :salt),
                   min_len: Application.get_env(:hashids, :min_len)
                 )

  def type do
    :id
  end

  require Cl

  def cast(id) when is_integer(id) do
    dump(id)
  end

  def cast(hash) when is_binary(hash) do
    Cl.inspect(hash, label: "-b  Called cast on hash")
    dump(hash)
  end

  def dump(id) when is_integer(id) do
    {:ok, id}
  end

  def dump(hash) when is_binary(hash) do
    case Hashids.decode(@local_encoder, hash) do
      {:ok, id} ->
        {:ok, hd(id)} |> Cl.inspect(label: "-b  Called dump on hash")

      _ ->
        :error
    end
  end

  def load(id) do
    {:ok, Hashids.encode(@local_encoder, id)}
  end
end
