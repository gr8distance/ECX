defmodule Ecx.Entity.Tag do
  @type t :: %__MODULE__{name: String.t()}
  defstruct name: ""

  @spec new(String.t()) :: t
  def new(name) do
    %__MODULE__{name: name}
  end
end
