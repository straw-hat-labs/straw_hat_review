defmodule StrawHat.Review.ReviewAspect do
  @moduledoc """
  Represents a ReviewAspect Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.{Review, Aspect}

  @typedoc """
  - `review`: `t:StrawHat.Review.Review.t/0` associated with the current review aspect.
  - `review_id`: The review used for the review aspect.
  - `aspect`: `t:StrawHat.Review.Aspect.t/0` associated with the current review aspect.
  - `aspect_id`: The aspect used for the review aspect.
  - `score`: The punctuation received for the reviewer in the range of 1 to 5 for the aspect.
  """
  @type t :: %__MODULE__{
          review: Review.t() | Ecto.Association.NotLoaded.t(),
          review_id: Integer.t(),
          aspect: Aspect.t() | Ecto.Association.NotLoaded.t(),
          aspect_id: Integer.t(),
          score: Integer.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type review_aspect_attrs :: %{
          review_id: Integer.t(),
          aspect_id: Integer.t(),
          score: String.t()
        }

  @required_fields ~w(review_id aspect_id score)a

  schema "reviews_aspects" do
    belongs_to(:review, Review)
    belongs_to(:aspect, Aspect)
    field(:score, :integer)

    timestamps()
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current ReviewAspect.
  """
  @since "1.0.0"
  @spec changeset(t, review_aspect_attrs) :: Ecto.Changeset.t()
  def changeset(review_aspect, review_aspect_attrs) do
    review_aspect
    |> cast(review_aspect_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:review)
    |> assoc_constraint(:aspect)
  end
end
