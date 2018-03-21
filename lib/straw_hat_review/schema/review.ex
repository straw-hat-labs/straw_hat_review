defmodule StrawHat.Review.Schema.Review do
  @moduledoc """
  Represents a Review Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Schema.{Review, Tag, ReviewTag, Feedback, ReviewAspect}

  @typedoc """
  - `date`: The write date of review.
  - `score`: The punctuation received for the reviewer in the range of 1 to 5.
  - `reviewee_id`: The object or user that receive the review.
  - `reviewer_id`: The user that make the comment.
  - `type`: The tag for mark the review for example customer, performer.
  - `comment`: The user comment or appreciation above the reviewee.
  - `review`: `t:StrawHat.Review.Schema.Review.t/0` associated with the current review.
  - `review_id`: Represent the relation betwwen review from reviews.
  - `tags`: List of `t:StrawHat.Review.Schema.Tag.t/0` associated with the current review.
  - `reviews`: List of `t:StrawHat.Review.Schema.Review.t/0` associated with the current review.
  - `feedbacks`: List of `t:StrawHat.Review.Schema.Feedback.t/0` associated with the current review.
  - `review_aspects`: List of `t:StrawHat.Review.Schema.ReviewAspect.t/0` associated with the current review.
  """
  @type t :: %__MODULE__{
          date: DateTime.t(),
          score: Integer.t(),
          reviewee_id: String.t(),
          reviewer_id: String.t(),
          type: String.t(),
          comment: String.t(),
          review: Review.t() | Ecto.Association.NotLoaded.t(),
          review_id: Integer.t(),
          tags: [Tag.t()] | Ecto.Association.NotLoaded.t(),
          reviews: [Review.t()] | Ecto.Association.NotLoaded.t(),
          feedbacks: [Feedback.t()] | Ecto.Association.NotLoaded.t(),
          review_aspects: [ReviewAspect.t()] | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type review_attrs :: %{
          date: DateTime.t(),
          score: Integer.t(),
          reviewee_id: String.t(),
          reviewer_id: String.t(),
          type: String.t(),
          comment: String.t(),
          review_id: Integer.t(),
          name: String.t()
        }

  @required_fields ~w(date score reviewee_id reviewer_id comment)a
  @optional_fields ~w(type review_id)a

  schema "reviews" do
    field(:date, :utc_datetime)
    field(:score, :integer)
    field(:reviewee_id, :string)
    field(:reviewer_id, :string)
    field(:type, :string)
    field(:comment, :string)
    belongs_to(:review, Review)

    has_many(:reviews, Review)
    has_many(:feedbacks, Feedback)
    has_many(:review_aspects, ReviewAspect)

    many_to_many(
      :tags,
      Tag,
      join_through: ReviewTag,
      on_replace: :delete,
      on_delete: :delete_all,
      unique: true
    )
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Review.
  """
  @spec changeset(t, review_attrs) :: Ecto.Changeset.t()
  def changeset(review, review_attrs) do
    review
    |> cast(review_attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:review)
  end
end
