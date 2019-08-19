defmodule StrawHat.Review.Aspect do
  @moduledoc """
  Represents an Aspect Ecto Schema.

  A Aspect represents some feature that you could
  highlight on your review.

  ### Example

      %StrawHat.Review.Aspect{
        name: "seller_communication"
      }

      %StrawHat.Review.Aspect{
        name: "service_as_described"
      }

      %StrawHat.Review.Aspect{
        name: "would_recommend"
      }


  You could take some inspiration from
  Uber, Lyft and Fiverr businesses.
  """

  use StrawHat.Review.Schema

  @name_regex ~r/^[a-z]+[a-z_]+[a-z]$/

  @typedoc """
  - `name`: The name of the aspect.
  """
  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: String.t() | nil,
          name: String.t() | nil,
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t()| nil
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type aspect_attrs :: %{
          name: String.t()
        }

  @required_fields ~w(name)a

  schema "aspects" do
    field(:name, :string)

    timestamps()
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current Aspect.
  """
  @spec changeset(t, aspect_attrs | %{}) :: Ecto.Changeset.t()
  def changeset(aspect, aspect_attrs) do
    aspect
    |> cast(aspect_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_name()
  end

  defp validate_name(changeset) do
    changeset
    |> update_change(:name, &cleanup_name/1)
    |> validate_format(:name, @name_regex)
    |> unique_constraint(:name)
  end

  defp cleanup_name(name) do
    name
    |> String.trim()
    |> String.replace(~r/\s/, "_")
    |> String.downcase()
  end
end
