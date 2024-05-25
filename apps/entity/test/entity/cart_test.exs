defmodule Ecx.Entity.CartTest do
  use ExUnit.Case
  doctest Ecx

  alias Ecx.Entity.{Cart, CartItem, Product, ProductMaster, User, Wallet}
  require IEx

  setup do
    user = User.new("alice", "alice@mail.com")
    wallet = Wallet.new(user)
    product_master = ProductMaster.new("master", "説明")
    {:ok, user: user, wallet: wallet, product_master: product_master}
  end

  test "newはカートを作成する", state do
    cart = Cart.new(state[:user])
    assert cart.items == []
  end

  test "newはカート内の商品を受け取って新しいカートを作成する", state do
    items = [
      CartItem.new(Product.new("product1", 1000, state[:product_master]), 1),
      CartItem.new(Product.new("product2", 3000, state[:product_master]), 3)
    ]

    cart = Cart.new(state[:user], items)
    assert cart.items == items
  end

  test "addはカートと商品とカートに入れる商品数量を受け取り、新しいカートを返す", state do
    product = Product.new("product1", 1000, state[:product_master])
    cart = Cart.new(state[:user])
    quantity = 3
    {:ok, updated_cart} = Cart.add(cart, product, quantity)
    assert updated_cart.items |> length == 1
    item = updated_cart.items |> List.first()
    assert item |> Map.get(:quantity) == quantity
    assert item |> Map.get(:product) == product
  end

  test "addはカートに同じ商品が既に入っている場合、引数の数量を加算する", state do
    product = Product.new("product1", 1000, state[:product_master])
    default_quantity = 1
    cart = Cart.new(state[:user], [CartItem.new(product, default_quantity)])
    add_quantity = 3
    {:ok, updated_cart} = Cart.add(cart, product, add_quantity)
    assert updated_cart.items |> length == 1
    item = updated_cart.items |> List.first()
    assert item |> Map.get(:quantity) == default_quantity + add_quantity
    assert item |> Map.get(:product) == product
  end

  test "subはカート内の商品数を引数の数量分減算する", state do
    product = Product.new("product1", 1000, state[:product_master])
    default_quantity = 3
    cart = Cart.new(state[:user], [CartItem.new(product, default_quantity)])
    sub_quantity = 2
    {:ok, updated_cart} = Cart.sub(cart, product, sub_quantity)
    assert updated_cart.items |> length == 1
    item = updated_cart.items |> List.first()
    assert item |> Map.get(:quantity) == default_quantity - sub_quantity
    assert item |> Map.get(:product) == product
  end

  test "subはカート内の商品数以上の数量を減算できない", state do
    product = Product.new("product1", 1000, state[:product_master])
    default_quantity = 3
    cart = Cart.new(state[:user], [CartItem.new(product, default_quantity)])
    sub_quantity = default_quantity + 1
    {:failed, updated_cart} = Cart.sub(cart, product, sub_quantity)
    assert updated_cart.items |> length == 1
    item = updated_cart.items |> List.first()
    assert item |> Map.get(:quantity) == default_quantity
    assert item |> Map.get(:product) == product
  end

  test "calc_priceはカート内の商品の合計金額を計算する", state do
    product1 = Product.new("product1", 1000, state[:product_master])
    product2 = Product.new("product2", 3000, state[:product_master])

    cart =
      Cart.new(state[:user], [
        CartItem.new(product1, 1),
        CartItem.new(product2, 3)
      ])

    assert Cart.calc_price(cart) == 10000
  end

  # NOTE: checkoutの処理はUseCaseに切り出した方が良いかも
  test "checkoutはカートを受け取りカート内の商品の合計金額をユーザのWalletに請求する", state do
    user = state[:user]

    product1 = Product.new("product1", 1000, state[:product_master])
    product2 = Product.new("product2", 3000, state[:product_master])

    cart =
      Cart.new(user, [
        CartItem.new(product1, 1),
        CartItem.new(product2, 3)
      ])

    total_price = Cart.calc_price(cart)

    wallet = state[:wallet]
    {:ok, new_wallet} = Cart.checkout(cart, wallet)
    assert new_wallet.balance == total_price * -1
    assert new_wallet.transactions |> length == 1
    assert new_wallet.transactions |> List.first() |> Map.get(:amount) == total_price * -1
  end

  test "to_orderはカートを受け取りorderEntityを返す", state do
    user = state[:user]
    product1 = Product.new("product1", 1000, state[:product_master])
    product2 = Product.new("product2", 3000, state[:product_master])

    cart =
      Cart.new(user, [
        CartItem.new(product1, 1),
        CartItem.new(product2, 3)
      ])

    order = Cart.to_order(cart)
    assert order.user == user
    assert order.items |> length == 2
    assert order.price == Cart.calc_price(cart)

    order.items
    |> Enum.zip([product1, product2])
    |> Enum.each(fn {item, product} ->
      assert item.product == product
    end)
  end
end
