defmodule Entity.User do
  @type t :: %__MODULE__{id: String.t(), name: String.t(), email: String.t()}
  defstruct id: "", name: "", email: ""

  @spec new(String.t(), String.t()) :: t
  def new(name, email) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      email: email
    }
  end
end
