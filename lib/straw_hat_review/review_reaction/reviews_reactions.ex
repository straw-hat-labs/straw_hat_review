defmodule StrawHat.Review.ReviewsReactions do
  @moduledoc """
  Interactor module that defines all the functionality for ReviewsReactions management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.ReviewReaction

  @doc """
  Gets the list of reviews reactions.
  """
  @since "1.0.0"
  @spec get_reviews_reactions(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_reviews_reactions(pagination \\ []), do: Repo.paginate(ReviewReaction, pagination)

  @doc """
  Creates reviews reaction.
  """
  @since "1.0.0"
  @spec create_reviews_reactions(ReviewReaction.reviews_reactions_attrs()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def create_reviews_reactions(reviews_reactions_attrs) do
    %ReviewReaction{}
    |> ReviewReaction.changeset(reviews_reactions_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates reviews reactions.
  """
  @since "1.0.0"
  @spec update_reviews_reactions(ReviewReaction.t(), ReviewReaction.reviews_reactions_attrs()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def update_reviews_reactions(%ReviewReaction{} = reviews_reactions, reviews_reactions_attrs) do
    reviews_reactions
    |> ReviewReaction.changeset(reviews_reactions_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys reviews reactions.
  """
  @since "1.0.0"
  @spec destroy_reviews_reactions(ReviewReaction.t()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def destroy_reviews_reactions(%ReviewReaction{} = reviews_reactions), do: Repo.delete(reviews_reactions)

  @doc """
  Finds reviews reactions by `id`.
  """
  @since "1.0.0"
  @spec find_reviews_reactions(Integer.t()) :: {:ok, ReviewReaction.t()} | {:error, Error.t()}
  def find_reviews_reactions(review_reaction_id) do
    review_reaction_id
    |> get_review_reaction()
    |> StrawHat.Response.from_value(
      Error.new(
        "straw_hat_review.review_reaction.not_found",
        metadata: [review_reaction_id: review_reaction_id]
      )
    )
  end

  @doc """
  Gets reviews reactions by `id`.
  """
  @since "1.0.0"
  @spec get_review_reaction(Integer.t()) :: ReviewReaction.t() | nil | no_return
  def get_review_reaction(review_reaction_id), do: Repo.get(ReviewReaction, review_reaction_id)
end
