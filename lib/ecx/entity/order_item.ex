defmodule Ecx.Entity.OrderItem do
  alias Ecx.Entity.Product

  @type t :: %__MODULE__{product: Product.t(), quantity: integer, price: integer}
  defstruct product: nil, quantity: 0, price: 0

  def new(cart_item) do
    %__MODULE__{
      product: cart_item.product,
      quantity: cart_item.quantity,
      price: cart_item.product.price
    }
  end

  @spec new(Product.t(), integer) :: t
  def new(product, quantity) do
    %__MODULE__{
      product: product,
      quantity: quantity,
      price: product.price
    }
  end
end
