defprotocol Entity.CampaignUsable do
  alias Entity.{Cart, User}

  @spec usable?(any, Cart.t(), User.t()) :: boolean
  def usable?(condition, cart, user)
end
