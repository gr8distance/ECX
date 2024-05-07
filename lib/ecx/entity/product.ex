defmodule Ecx.Entity.Product do
  alias Ecx.Entity.{Category, Tag}

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          price: integer(),
          categories: [Category.t()],
          tags: [Tag.t()]
        }
  defstruct id: "", name: "", price: 0, categories: [], tags: []

  @spec new(String.t(), integer()) :: t
  def new(name, price) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      price: price,
      categories: [],
      tags: []
    }
  end

  @spec new(String.t(), integer(), [Category.t()], [Tag.t()]) :: t
  def new(name, price, categories, tags) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      price: price,
      categories: categories,
      tags: tags
    }
  end
end
