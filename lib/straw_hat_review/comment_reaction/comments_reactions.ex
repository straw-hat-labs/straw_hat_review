defmodule StrawHat.Review.CommentsReactions do
  @moduledoc """
  Interactor module that defines all the functionality for CommentsReactions management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.CommentReaction

  @doc """
  Get the list of comments_reactions.
  """
  @since "1.0.0"
  @spec get_comments_reactions(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_comments_reactions(pagination \\ []), do: Repo.paginate(CommentReaction, pagination)

  @doc """
  Create comments_reaction.
  """
  @since "1.0.0"
  @spec create_comments_reactions(CommentReaction.comment_reaction_attrs()) ::
          {:ok, CommentReaction.t()} | {:error, Ecto.Changeset.t()}
  def create_comments_reactions(comment_reaction_attrs) do
    %CommentReaction{}
    |> CommentReaction.changeset(comment_reaction_attrs)
    |> Repo.insert()
  end

  @doc """
  Update comments_reaction.
  """
  @since "1.0.0"
  @spec update_comments_reactions(CommentReaction.t(), CommentReaction.comment_reaction_attrs()) ::
          {:ok, CommentReaction.t()} | {:error, Ecto.Changeset.t()}
  def update_comments_reactions(%CommentReaction{} = comments_reactions, comment_reaction_attrs) do
    comments_reactions
    |> CommentReaction.changeset(comment_reaction_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy comments_reaction.
  """
  @since "1.0.0"
  @spec destroy_comments_reactions(CommentReaction.t()) ::
          {:ok, CommentReaction.t()} | {:error, Ecto.Changeset.t()}
  def destroy_comments_reactions(%CommentReaction{} = comments_reactions), do: Repo.delete(comments_reactions)

  @doc """
  Find comments_reaction by `id`.
  """
  @since "1.0.0"
  @spec find_comments_reactions(Integer.t()) :: {:ok, CommentReaction.t()} | {:error, Error.t()}
  def find_comments_reactions(comment_reaction_id) do
    case get_comment_reaction(comment_reaction_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.comments_reaction.not_found",
            metadata: [comment_reaction_id: comment_reaction_id]
          )

        {:error, error}

      comments_reactions ->
        {:ok, comments_reactions}
    end
  end

  @doc """
  Get comments_reaction by `id`.
  """
  @since "1.0.0"
  @spec get_comment_reaction(Integer.t()) :: CommentReaction.t() | nil | no_return
  def get_comment_reaction(comment_reaction_id), do: Repo.get(CommentReaction, comment_reaction_id)
end
