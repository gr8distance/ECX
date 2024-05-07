defmodule Ecx.Entity.Category do
  @type t :: %__MODULE__{name: String.t(), description: String.t()}
  defstruct name: "", description: ""

  @spec new(String.t(), String.t()) :: t
  def new(name, description) do
    %__MODULE__{name: name, description: description}
  end
end
