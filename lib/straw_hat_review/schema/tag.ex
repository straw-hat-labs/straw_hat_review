defmodule StrawHat.Review.Schema.Tag do
  @moduledoc """
  Represents a Tag Ecto Schema.
  """

  use StrawHat.Review.Schema

  @typedoc """
  - ***name:*** The tag identificator above another tags.
  """
  @type t :: %__MODULE__{
          name: String.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type tag_attrs :: %{
          name: String.t()
        }

  @required_fields ~w(name)a

  schema "tags" do
    field(:name, :string)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Tag.
  """
  @spec changeset(t, tag_attrs) :: Ecto.Changeset.t()
  def changeset(tag, tag_attrs) do
    tag
    |> cast(tag_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :tags_name_index)
  end
end
