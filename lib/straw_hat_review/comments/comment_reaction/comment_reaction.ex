defmodule StrawHat.Review.CommentReaction do
  @moduledoc """
  Represents a CommentReaction Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.{Comment, Reaction}

  @typedoc """
  - `comment`: `t:StrawHat.Review.Comment.t/0` associated with the current comment reaction.
  - `comment_id`: The comment used for the comment reaction.
  - `reaction`: `t:StrawHat.Review.Reaction.t/0` associated with the current comment reaction.
  - `reaction_id`: The reaction used for the comment reaction.
  - `user_id`: The user that react to comment.
  """
  @type t :: %__MODULE__{
          comment: Comment.t() | Ecto.Association.NotLoaded.t(),
          comment_id: Integer.t(),
          reaction: Reaction.t() | Ecto.Association.NotLoaded.t(),
          reaction_id: Integer.t(),
          user_id: String.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type comment_reaction_attrs :: %{
          comment_id: Integer.t(),
          reaction_id: Integer.t(),
          user_id: String.t()
        }

  @required_fields ~w(comment_id reaction_id user_id)a

  schema "comments_reactions" do
    belongs_to(:comment, Comment)
    belongs_to(:reaction, Reaction)
    field(:user_id, :string)

    timestamps()
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current CommentReaction.
  """
  @spec changeset(t, comment_reaction_attrs) :: Ecto.Changeset.t()
  def changeset(comment_reaction, comment_reaction_attrs) do
    comment_reaction
    |> cast(comment_reaction_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:comment)
    |> assoc_constraint(:reaction)
    |> unique_constraint(:comment_id, name: :comments_reactions_comment_id_user_id_index)
  end
end
