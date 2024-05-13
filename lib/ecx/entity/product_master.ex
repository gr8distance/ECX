defmodule Ecx.Entity.ProductMaster do
  alias Ecx.Entity.{Category, Product}

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          description: String.t(),
          categories: [Category.t()],
          variants: [Product.t()]
        }
  defstruct id: "", name: "", description: "", categories: [], variants: []

  @spec new(String.t(), String.t()) :: t
  def new(name, description) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      description: description,
      categories: [],
      variants: []
    }
  end

  @spec new(String.t(), String.t(), [Category.t()], [Product.t()]) :: t
  def new(name, description, categories, products) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      description: description,
      categories: categories,
      variants: products
    }
  end
end
