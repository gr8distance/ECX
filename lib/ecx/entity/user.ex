defmodule Ecx.Entity.User do
  @type t :: %__MODULE__{name: String.t(), email: String.t()}
  defstruct name: "", email: ""

  @spec new(String.t(), String.t()) :: t
  def new(name, email) do
    %__MODULE__{name: name, email: email}
  end
end
