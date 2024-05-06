defmodule Ecx.Entity.Cart do
  alias Ecx.Entity.{CartItem, Product}

  @type t :: %__MODULE__{items: [CartItem.t()]}
  defstruct items: []

  @spec new() :: t
  def new() do
    %__MODULE__{items: []}
  end

  @spec new([CartItem.t()]) :: t
  def new(items) do
    %__MODULE__{items: items}
  end

  @spec add(t, Product.t(), integer) :: t
  def add(cart, product, quantity) do
    item = find_item(cart, product)

    case item do
      nil -> add_new(cart, product, quantity)
      _ -> update_quantity(cart, product, item.quantity + quantity)
    end
  end

  @spec sub(t, Product.t(), integer) :: t
  def sub(cart, product, quantity) do
    item = find_item(cart, product)

    case item do
      nil -> cart
      _ -> update_quantity(cart, product, item.quantity - quantity)
    end
  end

  @spec update_quantity(t, Product.t(), integer) :: t
  defp update_quantity(cart, product, quantity) do
    cart.items
    |> Enum.reject(fn item -> item.product == product end)
    |> new()
    |> add_new(product, quantity)
  end

  @spec add_new(t, Product.t(), integer) :: t
  defp add_new(cart, product, quantity) do
    cart.items
    |> Kernel.++([create_item(product, quantity)])
    |> new()
  end

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
