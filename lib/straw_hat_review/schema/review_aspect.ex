defmodule StrawHat.Review.Schema.ReviewAspect do
  @moduledoc """
  Represents a Review Aspect Ecto Schema relation.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Schema.{Review, Aspect}

  @typedoc """
  - ***review_id:*** The `review_id` is a reference to Review schema.
  - ***aspect_id:*** The `accomplistment_id` is a reference to Aspect schema.
  - ***comment:*** The user `comment` or appreciation above the aspect.
  - ***score:*** The punctuation received for the aspect in the range of 1 to 5.
  """
  @type t :: %__MODULE__{
          review_id: Integer.t(),
          aspect_id: Integer.t(),
          comment: String.t(),
          score: Integer.t()
        }

  @typedoc """
  Check `t` type for more information about the keys.
  """
  @type review_aspect_attrs :: %{
          review_id: Integer.t(),
          aspect_id: Integer.t(),
          comment: String.t(),
          score: Integer.t()
        }

  @required_fields ~w(review_id aspect_id comment score)a

  @primary_key false
  schema "review_aspects" do
    belongs_to(:review, Review)
    belongs_to(:aspect, Aspect)
    field(:comment, :string)
    field(:score, :integer)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Review Aspect.
  """
  @spec changeset(t, review_aspect_attrs) :: Ecto.Changeset.t()
  def changeset(review_aspect, review_aspect_attrs) do
    review_aspect
    |> cast(review_aspect_attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
