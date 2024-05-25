defmodule Entity.Product do
  alias Ecx.Entity.{Tag, ProductMaster}

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          price: integer(),
          tags: [Tag.t()],
          master: ProductMaster.t()
        }
  defstruct id: "", name: "", price: 0, tags: [], master: %ProductMaster{}

  @spec new(String.t(), integer(), ProductMaster.t()) :: t
  def new(name, price, master) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      price: price,
      master: master,
      tags: []
    }
  end

  @spec new(String.t(), integer(), ProductMaster.t(), [Tag.t()]) :: t
  def new(name, price, master, tags) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      price: price,
      master: master,
      tags: tags
    }
  end
end
