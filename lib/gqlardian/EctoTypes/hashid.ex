defmodule GQLardian.EctoTypes.Hashid do
  @behaviour Ecto.Type

  @local_encoder Hashids.new(
                   salt: Application.get_env(:hashids, :salt),
                   min_len: Application.get_env(:hashids, :min_len)
                 )

  def type do
    :id
  end

  def cast(id) when is_integer(id) do
    dump(id)
  end

  def cast(hash) when is_binary(hash) do
    dump(hash)
  end

  def dump(id) when is_integer(id) do
    {:ok, id}
  end

  def dump(hash) when is_binary(hash) do
    case Hashids.decode(@local_encoder, hash) do
      {:ok, id} ->
        {:ok, hd(id)}

      _ ->
        :error
    end
  end

  def load(id) do
    {:ok, Hashids.encode(@local_encoder, id)}
  end
end
