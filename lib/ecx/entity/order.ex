defmodule Ecx.Entity.Order do
  alias Ecx.Entity.{OrderItem, User, Cart}

  @type t :: %__MODULE__{
          id: String.t(),
          items: [OrderItem.t()],
          price: integer
        }
  defstruct id: "", user: %User{}, items: [], price: 0

  @spec new(Cart.t()) :: t
  def new(cart) do
    order_items =
      cart.items
      |> Enum.map(fn item ->
        OrderItem.new(item)
      end)

    %__MODULE__{
      id: UUID.uuid4(),
      user: cart.user,
      items: order_items,
      price: Cart.calc_price(cart)
    }
  end
end
