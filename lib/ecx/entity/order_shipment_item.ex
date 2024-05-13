defmodule Ecx.Entity.OrderShipmentItem do
  alias Ecx.Entity.{OrderItem}

  @type t :: %__MODULE__{
          id: String.t(),
          order_item: OrderItem.t(),
          quantity: integer
        }
  defstruct id: "", order_item: %OrderItem{}, quantity: 1

  @spec new(OrderItem.t(), integer) :: t
  def new(order_item, quantity) do
    %__MODULE__{
      id: UUID.uuid4(),
      order_item: order_item,
      quantity: quantity
    }
  end
end
