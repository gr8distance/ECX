defmodule Ecx.Entity.CampaignUsable.IncludeProduct do
  alias Ecx.Entity.{User, Product}

  @type t :: %__MODULE__{products: [Product.t()]}
  defstruct products: []
end

defimpl Ecx.Entity.CampaignUsable, for: Ecx.Entity.CampaignUsable.IncludeProduct do
  alias Ecx.Entity.CampaignUsable.IncludeProduct
  alias Ecx.Entity.{Cart, User}

  @spec usable?(IncludeProduct.t(), Cart.t(), User.t()) :: boolean
  def usable?(condition, cart, _user) do
    products_in_cart =
      cart.items
      |> Enum.map(fn item -> item.product end)

    condition.products
    |> Enum.any?(fn product ->
      products_in_cart
      |> Enum.member?(product)
    end)
  end
end
