defmodule Entity.CampaignTest do
  use ExUnit.Case

  alias Entity.{Campaign, Product, ProductMaster}
  alias Entity.CampaignUsable.IncludeProduct
  require IEx

  test "newはキャンペーンを作成する" do
    master = ProductMaster.new("master", "説明")
    product = Product.new("商品", 1000, master)

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
