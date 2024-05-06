defmodule Ecx.Entity.Wallet do
  alias Ecx.Entity.{User, WalletTransaction}
  require IEx

  @type t :: %__MODULE__{
          id: String.t(),
          user: User.t(),
          balance: integer,
          transactions: [WalletTransaction.t()]
        }
  defstruct id: "", user: %User{}, balance: 0, transactions: []

  @spec new(User.t()) :: t
  def new(user) do
    %__MODULE__{
      id: UUID.uuid4(),
      user: user,
      balance: 0
    }
  end

  @spec add_transaction(t, integer) :: t
  def add_transaction(wallet, amount) do
    transaction = create_transaction(wallet, amount)

    %{
      wallet
      | balance: wallet.balance + transaction.amount,
        transactions: [transaction | wallet.transactions]
    }
  end

  @spec create_transaction(t, integer) :: WalletTransaction.t()
  defp create_transaction(wallet, amount) do
    WalletTransaction.new(wallet, amount)
  end
end
