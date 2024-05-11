defmodule Ecx.Entity.Campaign do
  @type t :: %__MODULE__{
          name: String.t(),
          description: String.t(),
          discount_type: String.t(),
          amount: float(),
          conditions: []
        }
  defstruct name: "", description: "", discount_type: "", amount: 0.0, conditions: []

  # NOTE: conditionsはCampaign.Conditionを満たすモジュールの構造体のリスト
  @spec new(String.t(), String.t(), atom, float(), [any]) :: t
  def new(name, description, discount_type, amount, conditions) do
    %__MODULE__{
      name: name,
      description: description,
      discount_type: discount_type,
      amount: amount,
      conditions: conditions
    }
  end
end
