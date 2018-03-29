defmodule StrawHat.Review.Comment do
  @moduledoc """
  Represents a Comment Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.{CommentReaction, Review}

  @typedoc """
  - `comment`: The user comment or appreciation above the reviewee.
  - `owner_id`: The user that make the comment.
  - `review`: `t:StrawHat.Review.Review.t/0` associated with the current comment.
  - `review_id`: The review used for the comment.
  """
  @type t :: %__MODULE__{
          comment: String.t(),
          owner_id: String.t(),
          review: Review.t() | Ecto.Association.NotLoaded.t(),
          review_id: Integer.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type comment_attrs :: %{
          comment: String.t(),
          owner_id: String.t(),
          review_id: Integer.t()
        }

  @required_fields ~w(comment owner_id review_id)a

  schema "comments" do
    field(:comment, :string)
    field(:owner_id, :string)
    belongs_to(:review, Review)

    timestamps()

    has_many(
      :comments_reactions,
      CommentReaction,
      on_replace: :delete,
      on_delete: :delete_all
    )
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Comment.
  """
  @since "1.0.0"
  @spec changeset(t, comment_attrs) :: Ecto.Changeset.t()
  def changeset(comment, comment_attrs) do
    comment
    |> cast(comment_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:review)
  end
end
