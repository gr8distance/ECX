defmodule Entity.OrderPayment do
  alias Entity.{Order, PaymentMethod}

  @type t :: %__MODULE__{
          id: String.t(),
          order: Order.t(),
          method: PaymentMethod.t()
        }
  defstruct id: "", order: %Order{}, method: %PaymentMethod{}

  @spec new(Order.t(), Payment.t()) :: t
  def new(order, method) do
    %__MODULE__{
      id: UUID.uuid4(),
      order: order,
      method: method
    }
  end
end
