defprotocol Ecx.Entity.CampaignUsable do
  alias Ecx.Entity.{Cart, User}

  @spec usable?(any, Cart.t(), User.t()) :: boolean
  def usable?(condition, cart, user)
end
