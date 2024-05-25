defmodule Entity.OrderShipping do
  alias Ecx.Entity.{Order, OrderShipmentItem}

  @type t :: %__MODULE__{
          id: String.t(),
          order: Order.t(),
          items: [OrderShipmentItem.t()],
          name: String.t(),
          postal_code: String.t(),
          prefecture: String.t(),
          city: String.t(),
          street: String.t(),
          building: String.t(),
          email: String.t(),
          phone_number: String.t(),
          tracking_number: String.t(),
          delivery_company: String.t(),
          state: String.t(),
          shipped_at: DateTime.t()
        }
  defstruct id: "",
            order: %Order{},
            items: [],
            name: "",
            postal_code: "",
            prefecture: "",
            city: "",
            street: "",
            building: "",
            email: "",
            phone_number: "",
            tracking_number: "",
            delivery_company: "",
            state: "",
            shipped_at: DateTime.utc_now()
end
