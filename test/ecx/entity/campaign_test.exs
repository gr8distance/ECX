defmodule Ecx.Entity.CampaignTest do
  use ExUnit.Case
  doctest Ecx

  alias Ecx.Entity.{Campaign, Product}
  alias Ecx.Entity.CampaignUsable.IncludeProduct
  require IEx

  test "newはキャンペーンを作成する" do
    product = Product.new("商品", 1000)

    conditions = [
      %IncludeProduct{products: [product]}
    ]

    campaign = Campaign.new("キャンペーン", "説明", :-, 1000.0, conditions)
    assert campaign.name == "キャンペーン"
    assert campaign.description == "説明"
    assert campaign.discount_type == :-
    assert campaign.amount == 1000.0
    assert campaign.conditions == conditions
  end
end
