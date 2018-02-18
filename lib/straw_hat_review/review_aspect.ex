defmodule StrawHat.Review.ReviewAspect do
  @moduledoc """
  Interactor module that defines all the functionality for ReviewAspect management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.ReviewAspect

  @doc """
  Get the list of review_aspects.
  """
  @spec get_review_aspects(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_review_aspects(pagination \\ []), do: Repo.paginate(ReviewAspect, pagination)

  @doc """
  Create a review_aspect.
  """
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
  @spec destroy_review_aspect(ReviewAspect.t()) :: {:ok, ReviewAspect.t()} | {:error, Ecto.Changeset.t()}
  def destroy_review_aspect(%ReviewAspect{} = review_aspect), do: Repo.delete(review_aspect)

  @doc """
  Find a review_aspect by `id`.
  """
  @spec find_review_aspect(String.t()) :: {:ok, ReviewAspect.t()} | {:error, Error.t()}
  def find_review_aspect(review_aspect_id) do
    case get_review_aspect(review_aspect_id) do
      nil ->
        error =
          Error.new("straw_hat_review.review_aspect.not_found", metadata: [review_aspect_id: review_aspect_id])

        {:error, error}

      review_aspect ->
        {:ok, review_aspect}
    end
  end

  @doc """
  Get a review_aspect by `id`.
  """
  @spec get_review_aspect(String.t()) :: ReviewAspect.t() | nil | no_return
  def get_review_aspect(review_aspect_id), do: Repo.get(ReviewAspect, review_aspect_id)
end
