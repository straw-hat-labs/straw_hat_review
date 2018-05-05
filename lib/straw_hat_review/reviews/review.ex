defmodule StrawHat.Review.Review do
  @moduledoc """
  Represents a Review Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.{Comment, Media, ReviewAspect, ReviewReaction}

  @typedoc """
  - `reviewee_id`: The object or user that receive the review.
  - `reviewer_id`: The user that make the comment.
  - `comment`: The user comment or appreciation above the reviewee.
  - `comments`: List of `t:StrawHat.Review.Comment.t/0` associated with the
  current review.
  - `medias`: List of `t:StrawHat.Review.Media.t/0` associated with the
  current review.
  - `aspects`: List of `t:StrawHat.Review.ReviewAspect.t/0` associated with
  the current review.
  - `reactions`: List of `t:StrawHat.Review.ReviewReaction.t/0`
  associated with the current review.
  """
  @type t :: %__MODULE__{
          reviewee_id: String.t(),
          reviewer_id: String.t(),
          comment: String.t(),
          comments: [Comment.t()] | Ecto.Association.NotLoaded.t(),
          medias: [Media.t()] | Ecto.Association.NotLoaded.t(),
          aspects: [ReviewAspect.t()] | Ecto.Association.NotLoaded.t(),
          reactions: [ReviewReaction.t()] | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type review_attrs :: %{
          reviewee_id: String.t(),
          reviewer_id: String.t(),
          comment: String.t(),
          aspects: [ReviewAspect.t()],
          medias: [%Plug.Upload{}]
        }

  @required_fields ~w(reviewee_id reviewer_id comment)a

  schema "reviews" do
    field(:reviewee_id, :string)
    field(:reviewer_id, :string)
    field(:comment, :string)

    timestamps()

    has_many(
      :comments,
      Comment,
      on_replace: :delete,
      on_delete: :delete_all
    )

    has_many(
      :medias,
      Media,
      on_replace: :delete,
      on_delete: :delete_all
    )

    has_many(
      :aspects,
      ReviewAspect,
      on_replace: :delete,
      on_delete: :delete_all
    )

    has_many(
      :reactions,
      ReviewReaction,
      on_replace: :delete,
      on_delete: :delete_all
    )
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current Review.
  """
  @since "1.0.0"
  @spec changeset(t, review_attrs) :: Ecto.Changeset.t()
  def changeset(review, review_attrs) do
    review
    |> cast(review_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:aspects, required: true)
    |> cast_assoc(:medias)
  end
end
