defmodule Entity.WalletTest do
  use ExUnit.Case

  alias Entity.{Wallet, User}
  require IEx

  setup do
    {:ok, user: User.new("alice", "")}
  end

  test "newはユーザーのWalletを作成する", state do
    user = state[:user]
    wallet = Wallet.new(user)
    assert wallet.user == user
    assert wallet.balance == 0
  end

  test "add_transactionはトランザクションを追加する", state do
    user = state[:user]
    wallet = Wallet.new(user)

    all_amount = [1000, 2000, 3000]

    %{wallet: updated_wallet} =
      all_amount
      |> Enum.reduce(%{amount: 0, wallet: wallet}, fn amount, acc ->
        updated_wallet = Wallet.add_transaction(acc[:wallet], amount)
        assert updated_wallet.balance == acc[:amount] + amount

        %{amount: acc[:amount] + amount, wallet: updated_wallet}
      end)

    assert updated_wallet.balance == 6000
    assert updated_wallet.transactions |> length == 3

    updated_wallet.transactions
    |> Enum.zip(Enum.reverse(all_amount))
    |> Enum.each(fn {transaction, amount} ->
      assert transaction.amount == amount
    end)
  end
end
