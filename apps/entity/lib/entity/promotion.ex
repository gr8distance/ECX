defmodule Entity.Promotion do
  alias Ecx.Entity.Campaign

  @type t :: %__MODULE__{
          name: String.t(),
          description: String.t(),
          start_at: DateTime.t() | nil,
          end_at: DateTime.t() | nil,
          code: String.t(),
          campaigns: [Campaign.t()]
        }

  defstruct name: "",
            description: "",
            start_at: nil,
            end_at: nil,
            code: "",
            campaigns: []

  @spec new(String.t(), String.t(), String.t() | nil, [Campaign.t()]) :: t
  def new(name, description, code \\ nil, campaigns \\ []) do
    new(name, description, nil, nil, code, campaigns)
  end

  @spec new(String.t(), String.t(), DateTime.t() | nil, DateTime.t() | nil, String.t() | nil, [
          Campaign.t()
        ]) :: t
  def new(name, description, start_at, end_at, code, campaigns) do
    %__MODULE__{
      name: name,
      description: description,
      start_at: start_at,
      end_at: end_at,
      code: code || generate_code(),
      campaigns: campaigns
    }
  end

  @spec generate_code() :: String.t()
  defp generate_code do
    :crypto.strong_rand_bytes(8)
    |> Base.encode16()
    |> String.downcase()
  end
end
