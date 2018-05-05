defmodule StrawHat.Review.CommentReactions do
  @moduledoc """
  Interactor module that defines all the functionality for CommentsReactions management.
  """

  use StrawHat.Review.Interactor
  alias StrawHat.Response
  alias StrawHat.Review.CommentReaction

  @doc """
  Gets a list of comment reactions.
  """
  @since "1.0.0"
  @spec get_comment_reactions(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_comment_reactions(pagination \\ []), do: Repo.paginate(CommentReaction, pagination)

  @doc """
  Creates a comment reaction.
  """
  @since "1.0.0"
  @spec create_comment_reaction(CommentReaction.comment_reaction_attrs()) ::
          {:ok, CommentReaction.t()} | {:error, Ecto.Changeset.t()}
  def create_comment_reaction(comment_reaction_attrs) do
    %CommentReaction{}
    |> CommentReaction.changeset(comment_reaction_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates the comment reaction.
  """
  @since "1.0.0"
  @spec update_comment_reaction(CommentReaction.t(), CommentReaction.comment_reaction_attrs()) ::
          {:ok, CommentReaction.t()} | {:error, Ecto.Changeset.t()}
  def update_comment_reaction(%CommentReaction{} = comment_reaction, comment_reaction_attrs) do
    comment_reaction
    |> CommentReaction.changeset(comment_reaction_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys a comment reaction.
  """
  @since "1.0.0"
  @spec destroy_comment_reaction(CommentReaction.t()) ::
          {:ok, CommentReaction.t()} | {:error, Ecto.Changeset.t()}
  def destroy_comment_reaction(%CommentReaction{} = comment_reaction) do
    Repo.delete(comment_reaction)
  end

  @doc """
  Finds a comment reaction by `id`.
  """
  @since "1.0.0"
  @spec find_comment_reaction(Integer.t()) :: {:ok, CommentReaction.t()} | {:error, Error.t()}
  def find_comment_reaction(comment_reaction_id) do
    comment_reaction_id
    |> get_comment_reaction()
    |> Response.from_value(
      Error.new(
        "straw_hat_review.comment_reaction.not_found",
        metadata: [comment_reaction_id: comment_reaction_id]
      )
    )
  end

  @doc """
  Gets a comment reaction by `id`.
  """
  @since "1.0.0"
  @spec get_comment_reaction(Integer.t()) :: CommentReaction.t() | nil | no_return
  def get_comment_reaction(comment_reaction_id) do
    Repo.get(CommentReaction, comment_reaction_id)
  end
end
