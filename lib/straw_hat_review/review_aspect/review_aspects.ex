defmodule StrawHat.Review.ReviewAspects do
  @moduledoc """
  Interactor module that defines all the functionality for ReviewAspects management.
  """

  use StrawHat.Review.Interactor

  import Ecto.Query, only: [from: 2]
  alias StrawHat.Review.ReviewAspect

  @doc """
  Get the list of review_aspects.
  """
  @since "1.0.0"
  @spec get_review_aspects(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_review_aspects(pagination \\ []), do: Repo.paginate(ReviewAspect, pagination)

  @doc """
  Create a review_aspect.
  """
  @since "1.0.0"
  @spec create_review_aspect(ReviewAspect.review_aspect_attrs()) ::
          {:ok, ReviewAspect.t()} | {:error, Ecto.Changeset.t()}
  def create_review_aspect(review_aspect_attrs) do
    %ReviewAspect{}
    |> ReviewAspect.changeset(review_aspect_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a review_aspect.
  """
  @since "1.0.0"
  @spec update_review_aspect(ReviewAspect.t(), ReviewAspect.review_aspect_attrs()) ::
          {:ok, ReviewAspect.t()} | {:error, Ecto.Changeset.t()}
  def update_review_aspect(%ReviewAspect{} = review_aspect, review_aspect_attrs) do
    review_aspect
    |> ReviewAspect.changeset(review_aspect_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a review_aspect.
  """
  @since "1.0.0"
  @spec destroy_review_aspect(ReviewAspect.t()) ::
          {:ok, ReviewAspect.t()} | {:error, Ecto.Changeset.t()}
  def destroy_review_aspect(%ReviewAspect{} = review_aspect), do: Repo.delete(review_aspect)

  @doc """
  Find a review_aspect by `id`.
  """
  @since "1.0.0"
  @spec find_review_aspect(Integer.t()) :: {:ok, ReviewAspect.t()} | {:error, Error.t()}
  def find_review_aspect(review_aspect_id) do
    case get_review_aspect(review_aspect_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.review_aspect.not_found",
            metadata: [review_aspect_id: review_aspect_id]
          )

        {:error, error}

      review_aspect ->
        {:ok, review_aspect}
    end
  end

  @doc """
  Get a review_aspect by `id`.
  """
  @since "1.0.0"
  @spec get_review_aspect(Integer.t()) :: ReviewAspect.t() | nil | no_return
  def get_review_aspect(review_aspect_id), do: Repo.get(ReviewAspect, review_aspect_id)

  @doc """
  Get list of aspects by review aspect ids.
  """
  @since "1.0.0"
  @spec get_aspects([Integer.t()]) :: [Review.t()] | no_return
  def get_aspects(review_aspect_ids) do
    query =
      from(
        review_aspect in ReviewAspect,
        where: review_aspect.id in ^review_aspect_ids,
        join: aspect in assoc(review_aspect, :aspect),
        preload: [aspect: aspect]
      )

    Repo.all(query)
  end

  @doc """
  Get list of review by review aspect ids.
  """
  @since "1.0.0"
  @spec get_reviews([Integer.t()]) :: [Review.t()] | no_return
  def get_reviews(review_aspect_ids) do
    query =
      from(
        review_aspect in ReviewAspect,
        where: review_aspect.id in ^review_aspect_ids,
        join: review in assoc(review_aspect, :review),
        preload: [review: review]
      )

    Repo.all(query)
  end
end
