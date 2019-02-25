defmodule StrawHat.Review.ReviewReactions do
  @moduledoc """
  Interactor module that defines all the functionality for ReviewsReactions management.
  """

  use StrawHat.Review.Interactor
  alias StrawHat.Review.ReviewReaction

  @doc """
  Creates a review reaction.
  """
  @spec create_review_reaction(ReviewReaction.review_reaction_attrs()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def create_review_reaction(review_reaction_attrs) do
    %ReviewReaction{}
    |> ReviewReaction.changeset(review_reaction_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review reaction.
  """
  @spec update_review_reaction(ReviewReaction.t(), ReviewReaction.review_reaction_attrs()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def update_review_reaction(%ReviewReaction{} = review_reaction, review_reaction_attrs) do
    review_reaction
    |> ReviewReaction.changeset(review_reaction_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys a review reaction.
  """
  @spec destroy_review_reaction(ReviewReaction.t()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def destroy_review_reaction(%ReviewReaction{} = review_reaction) do
    Repo.delete(review_reaction)
  end

  @doc """
  Finds a review reaction by `id`.
  """
  @spec find_review_reaction(Integer.t()) :: {:ok, ReviewReaction.t()} | {:error, Error.t()}
  def find_review_reaction(review_reaction_id) do
    review_reaction_id
    |> get_review_reaction()
    |> Response.from_value(
      Error.new(
        "straw_hat_review.review_reaction.not_found",
        metadata: [review_reaction_id: review_reaction_id]
      )
    )
  end

  @doc """
  Gets a review reaction by `id`.
  """
  @spec get_review_reaction(Integer.t()) :: ReviewReaction.t() | nil | no_return
  def get_review_reaction(review_reaction_id) do
    Repo.get(ReviewReaction, review_reaction_id)
  end
end
