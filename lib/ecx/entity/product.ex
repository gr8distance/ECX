defmodule Ecx.Entity.Product do
  @type t :: %__MODULE__{id: String.t(), name: String.t(), price: integer()}
  defstruct id: "", name: "", price: 0

  @spec new(String.t(), integer()) :: t
  def new(name, price) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      price: price
    }
  end
end
