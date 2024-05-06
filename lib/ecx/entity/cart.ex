defmodule Ecx.Entity.Cart do
  alias Ecx.Entity.{CartItem, Product}

  @type t :: %__MODULE__{id: String.t(), items: [CartItem.t()]}
  defstruct id: "", items: []

  @spec new() :: t
  def new() do
    %__MODULE__{
      id: UUID.uuid4(),
      items: []
    }
  end

  @spec new([CartItem.t()]) :: t
  def new(items) do
    %__MODULE__{items: items}
  end

  @spec add(t, Product.t(), integer) :: {:ok, t}
  def add(cart, product, quantity) do
    item = find_item(cart, product)

    case item do
      nil -> add_new(cart, product, quantity)
      _ -> update_quantity(cart, product, item.quantity + quantity)
    end
  end

  @spec sub(t, Product.t(), integer) :: {:ok, t} | {:failed, t}
  def sub(cart, product, quantity) do
    item = find_item(cart, product)

    case item do
      nil -> cart
      _ -> update_quantity(cart, product, item.quantity - quantity)
    end
  end

  @spec calc_price(t) :: integer
  def calc_price(cart) do
    cart.items
    |> Enum.map(&(&1.price * &1.quantity))
    |> Enum.sum()
  end

  @spec update_quantity(t, Product.t(), integer) :: {:failed, t}
  defp update_quantity(cart, _product, quantity) when quantity <= 0 do
    make_failed_response(cart)
  end

  @spec update_quantity(t, Product.t(), integer) :: {:ok, t}
  defp update_quantity(cart, product, quantity) do
    cart.items
    |> Enum.reject(fn item -> item.product == product end)
    |> new()
    |> add_new(product, quantity)
  end

  @spec add_new(t, Product.t(), integer) :: {:ok, t}
  defp add_new(cart, product, quantity) do
    cart.items
    |> Kernel.++([create_item(product, quantity)])
    |> new()
    |> make_success_response()
  end

  @spec make_success_response(t) :: {:ok, t}
  defp make_success_response(cart), do: {:ok, cart}

  @spec make_failed_response(t) :: {:failed, t}
  defp make_failed_response(cart), do: {:failed, cart}

  @spec find_item(t, Product.t()) :: CartItem.t() | nil
  defp find_item(cart, product) do
    cart.items
    |> Enum.find(fn item -> item.product == product end)
  end

  @spec create_item(Product.t(), integer) :: CartItem.t()
  defp create_item(product, quantity) do
    CartItem.new(product, quantity)
  end
end
