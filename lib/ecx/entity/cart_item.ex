defmodule Ecx.Entity.CartItem do
  alias Ecx.Entity.Product

  @type t :: %__MODULE__{product: Product.t(), quantity: integer, price: integer}
  defstruct product: nil, quantity: 0, price: 0

  @spec new(Product.t(), integer) :: t
  def new(product, quantity) do
    %__MODULE__{
      product: product,
      quantity: quantity,
      price: product.price
    }
  end
end
