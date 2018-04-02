defmodule StrawHat.Review.ReviewsReactions do
  @moduledoc """
  Interactor module that defines all the functionality for ReviewsReactions management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.ReviewReaction

  @doc """
  Get the list of reviews_reactions.
  """
  @since "1.0.0"
  @spec get_reviews_reactions(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_reviews_reactions(pagination \\ []), do: Repo.paginate(ReviewReaction, pagination)

  @doc """
  Create reviews_reaction.
  """
  @since "1.0.0"
  @spec create_reviews_reaction(ReviewReaction.reviews_reaction_attrs()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def create_reviews_reaction(reviews_reaction_attrs) do
    %ReviewReaction{}
    |> ReviewReaction.changeset(reviews_reaction_attrs)
    |> Repo.insert()
  end

  @doc """
  Update reviews_reaction.
  """
  @since "1.0.0"
  @spec update_reviews_reaction(ReviewReaction.t(), ReviewReaction.reviews_reaction_attrs()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def update_reviews_reaction(%ReviewReaction{} = reviews_reaction, reviews_reaction_attrs) do
    reviews_reaction
    |> ReviewReaction.changeset(reviews_reaction_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy reviews_reaction.
  """
  @since "1.0.0"
  @spec destroy_reviews_reaction(ReviewReaction.t()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def destroy_reviews_reaction(%ReviewReaction{} = reviews_reaction), do: Repo.delete(reviews_reaction)

  @doc """
  Find reviews_reaction by `id`.
  """
  @since "1.0.0"
  @spec find_reviews_reaction(Integer.t()) :: {:ok, ReviewReaction.t()} | {:error, Error.t()}
  def find_reviews_reaction(reviews_reaction_id) do
    case get_reviews_reaction(reviews_reaction_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.reviews_reaction.not_found",
            metadata: [reviews_reaction_id: reviews_reaction_id]
          )

        {:error, error}

      reviews_reaction ->
        {:ok, reviews_reaction}
    end
  end

  @doc """
  Get reviews_reaction by `id`.
  """
  @since "1.0.0"
  @spec get_reviews_reaction(Integer.t()) :: ReviewReaction.t() | nil | no_return
  def get_reviews_reaction(reviews_reaction_id), do: Repo.get(ReviewReaction, reviews_reaction_id)
end
