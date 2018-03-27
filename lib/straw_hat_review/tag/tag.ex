defmodule StrawHat.Review.Tag do
  @moduledoc """
  Represents a Tag Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.ReviewTag

  @typedoc """
  - `name`: The tag identificator above another tags.
  - `review_tags`: List of `t:StrawHat.Review.ReviewTag.t/0` associated with the current tag.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          review_tags: [ReviewTag.t()] | Ecto.Association.NotLoaded.t()
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

    has_many(
      :review_tags,
      ReviewTag,
      on_replace: :delete,
      on_delete: :delete_all
    )
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Tag.
  """
  @since "1.0.0"
  @spec changeset(t, tag_attrs) :: Ecto.Changeset.t()
  def changeset(tag, tag_attrs) do
    tag
    |> cast(tag_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :tags_name_index)
  end
end
