defmodule StrawHat.Review.Comments do
  @moduledoc """
  Interactor module that defines all the functionality for Comments management.
  """

  use StrawHat.Review.Interactor

  import Ecto.Query, only: [from: 2]
  alias StrawHat.Review.Comment

  @doc """
  Get the list of comments.
  """
  @since "1.0.0"
  @spec get_comments(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_comments(pagination \\ []), do: Repo.paginate(Comment, pagination)

  @doc """
  Create comment.
  """
  @since "1.0.0"
  @spec create_comment(Comment.comment_attrs()) ::
          {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def create_comment(comment_attrs) do
    %Comment{}
    |> Comment.changeset(comment_attrs)
    |> Repo.insert()
  end

  @doc """
  Update comment.
  """
  @since "1.0.0"
  @spec update_comment(Comment.t(), Comment.comment_attrs()) ::
          {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def update_comment(%Comment{} = comment, comment_attrs) do
    comment
    |> Comment.changeset(comment_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy comment.
  """
  @since "1.0.0"
  @spec destroy_comment(Comment.t()) ::
          {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def destroy_comment(%Comment{} = comment), do: Repo.delete(comment)

  @doc """
  Find comment by `id`.
  """
  @since "1.0.0"
  @spec find_comment(Integer.t()) :: {:ok, Comment.t()} | {:error, Error.t()}
  def find_comment(comment_id) do
    case get_comment(comment_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.comment.not_found",
            metadata: [comment_id: comment_id]
          )

        {:error, error}

      comment ->
        {:ok, comment}
    end
  end

  @doc """
  Get comment by `id`.
  """
  @since "1.0.0"
  @spec get_comment(Integer.t()) :: Comment.t() | nil | no_return
  def get_comment(comment_id), do: Repo.get(Comment, comment_id)

  @doc """
  Get list of comment by ids.
  """
  @since "1.0.0"
  @spec comment_by_ids([Integer.t()]) :: [Comment.t()] | no_return
  def comment_by_ids(comment_ids) do
    query =
      from(comment in Comment,
        where: comment.id in ^comment_ids)

    Repo.all(query)
  end
end
