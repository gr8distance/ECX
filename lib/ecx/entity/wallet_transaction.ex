defmodule Ecx.Entity.WalletTransaction do
  alias Ecx.Entity.{User}

  @type t :: %__MODULE__{
          id: String.t(),
          user: User.t(),
          wallet_id: String.t(),
          amount: integer()
        }
  defstruct id: "", user: %User{}, wallet_id: "", amount: 0

  def new(wallet, amount) do
    %__MODULE__{
      id: UUID.uuid4(),
      user: wallet.user,
      wallet_id: wallet.id,
      amount: amount
    }
  end
end
