defmodule Ecx.Entity.CartTest do
  use ExUnit.Case
  doctest Ecx

  alias Ecx.Entity.{Cart, CartItem, Product}
  require IEx

  test "newはカートを作成する" do
    cart = Cart.new()
    assert cart.items == []
  end

  test "newはカート内の商品を受け取って新しいカートを作成する" do
    items = [
      CartItem.new(Product.new("product1", 1000), 1),
      CartItem.new(Product.new("product2", 3000), 3)
    ]

    cart = Cart.new(items)
    assert cart.items == items
  end

  test "addはカートと商品とカートに入れる商品数量を受け取り、新しいカートを返す" do
    product = Product.new("product1", 1000)
    cart = Cart.new()
    quantity = 3
    {:ok, updated_cart} = Cart.add(cart, product, quantity)
    assert updated_cart.items |> length == 1
    item = updated_cart.items |> List.first()
    assert item |> Map.get(:quantity) == quantity
    assert item |> Map.get(:product) == product
  end

  test "addはカートに同じ商品が既に入っている場合、引数の数量を加算する" do
    product = Product.new("product1", 1000)
    default_quantity = 1
    cart = Cart.new([CartItem.new(product, default_quantity)])
    add_quantity = 3
    {:ok, updated_cart} = Cart.add(cart, product, add_quantity)
    assert updated_cart.items |> length == 1
    item = updated_cart.items |> List.first()
    assert item |> Map.get(:quantity) == default_quantity + add_quantity
    assert item |> Map.get(:product) == product
  end

  test "subはカート内の商品数を引数の数量分減算する" do
    product = Product.new("product1", 1000)
    default_quantity = 3
    cart = Cart.new([CartItem.new(product, default_quantity)])
    sub_quantity = 2
    {:ok, updated_cart} = Cart.sub(cart, product, sub_quantity)
    assert updated_cart.items |> length == 1
    item = updated_cart.items |> List.first()
    assert item |> Map.get(:quantity) == default_quantity - sub_quantity
    assert item |> Map.get(:product) == product
  end

  test "subはカート内の商品数以上の数量を減算できない" do
    product = Product.new("product1", 1000)
    default_quantity = 3
    cart = Cart.new([CartItem.new(product, default_quantity)])
    sub_quantity = default_quantity + 1
    {:failed, updated_cart} = Cart.sub(cart, product, sub_quantity)
    assert updated_cart.items |> length == 1
    item = updated_cart.items |> List.first()
    assert item |> Map.get(:quantity) == default_quantity
    assert item |> Map.get(:product) == product
  end

  test "calc_priceはカート内の商品の合計金額を計算する" do
    product1 = Product.new("product1", 1000)
    product2 = Product.new("product2", 3000)

    cart =
      Cart.new([
        CartItem.new(product1, 1),
        CartItem.new(product2, 3)
      ])

    assert Cart.calc_price(cart) == 10000
  end
end
