defmodule Ecx.Entity.PaymentMethod do
  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          description: String.t()
        }
  defstruct id: "", name: "", description: ""

  @spec new(String.t(), String.t(), String.t()) :: t
  def new(id, name, description) do
    %__MODULE__{
      id: id,
      name: name,
      description: description
    }
  end
end
