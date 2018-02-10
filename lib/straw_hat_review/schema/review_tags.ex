defmodule StrawHat.Review.Schema.ReviewTags do
  @moduledoc """
  Represents a Review Tags Ecto Schema relation.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Schema.{Review, Tag}

  @typedoc """
  - ***review_id:*** The `review_id` is a reference to Review schema.
  - ***tag_id:*** The `tag_id` is a reference to Tag schema.
  """
  @type t :: %__MODULE__{
          review_id: Integer.t(),
          tag_id: Integer.t()
        }

  @typedoc """
  Check `t` type for more information about the keys.
  """
  @type review_tag_attrs :: %{
          review_id: Integer.t(),
          tag_id: Integer.t()
        }

  @required_fields ~w(template_id tag_id)a

  @primary_key false
  schema "review_tags" do
    belongs_to(:review, Review)
    belongs_to(:tag, Tag)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Review Tag.
  """
  @spec changeset(t, review_tag_attrs) :: Ecto.Changeset.t()
  def changeset(review_tag, review_tag_attrs) do
    review_tag
    |> cast(review_tag_attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
