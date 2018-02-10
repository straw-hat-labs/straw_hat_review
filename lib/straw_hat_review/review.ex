defmodule StrawHat.Review.Review do
  @moduledoc """
  Interactor module that defines all the functionality for Review management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.Review

  @doc """
  Get the list of reviews.
  """
  @spec get_reviews(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_reviews(pagination \\ []), do: Repo.paginate(Review, pagination)

  @doc """
  Create a review.
  """
  @spec create_review(Review.review_attrs()) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def create_review(review_attrs) do
    %Review{}
    |> Review.changeset(review_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a review.
  """
  @spec update_review(Review.t(), Review.review_attrs()) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def update_review(%Review{} = review, review_attrs) do
    review
    |> Review.changeset(review_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a review.
  """
  @spec destroy_review(Review.t()) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def destroy_review(%Review{} = review), do: Repo.delete(review)

  @doc """
  Find a review by `id`.
  """
  @spec find_review(String.t()) :: {:ok, Review.t()} | {:error, Error.t()}
  def find_review(review_id) do
    case get_review(review_id) do
      nil ->
        error = Error.new("straw_hat_review.review.not_found", metadata: [review_id: review_id])
        {:error, error}

      review ->
        {:ok, review}
    end
  end

  @doc """
  Get a review by `id`.
  """
  @spec get_review(String.t()) :: Review.t() | nil | no_return
  def get_review(review_id), do: Repo.get(Review, review_id)
end
