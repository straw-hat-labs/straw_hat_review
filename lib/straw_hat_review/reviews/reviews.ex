defmodule StrawHat.Review.Reviews do
  @moduledoc """
  Interactor module that defines all the functionality for Reviews management.
  """

  use StrawHat.Review.Interactor
  alias StrawHat.Review.{Review, ReviewReaction}

  @doc """
  Gets the list of reviews.
  """
  @since "1.0.0"
  @spec get_reviews(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_reviews(pagination \\ []), do: Repo.paginate(Review, pagination)

  @doc """
  Creates a review.
  """
  @since "1.0.0"
  @spec create_review(Review.review_attrs()) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def create_review(review_attrs) do
    %Review{}
    |> Review.changeset(review_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.
  """
  @since "1.0.0"
  @spec update_review(Review.t(), Review.review_attrs()) ::
          {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def update_review(%Review{} = review, review_attrs) do
    review
    |> Review.changeset(review_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys a review.
  """
  @since "1.0.0"
  @spec destroy_review(Review.t()) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def destroy_review(%Review{} = review), do: Repo.delete(review)

  @doc """
  Finds a review by `id`.
  """
  @since "1.0.0"
  @spec find_review(Integer.t()) :: {:ok, Review.t()} | {:error, Error.t()}
  def find_review(review_id) do
    review_id
    |> get_review()
    |> Response.from_value(
      Error.new(
        "straw_hat_review.review.not_found",
        metadata: [review_id: review_id]
      )
    )
  end

  @doc """
  Gets a review by `id`.
  """
  @since "1.0.0"
  @spec get_review(Integer.t()) :: Review.t() | nil | no_return
  def get_review(review_id) do
    query =
      from(
        review in Review,
        where: review.id == ^review_id,
        preload: [aspects: :aspect],
        preload: [:medias]
      )

    Repo.one(query)
  end

  @doc """
  Gets a list of review by ids.
  """
  @since "1.0.0"
  @spec get_review_by_ids([Integer.t()]) :: [Review.t()] | no_return
  def get_review_by_ids(review_ids) do
    query =
      from(
        review in Review,
        where: review.id in ^review_ids,
        preload: [aspects: :aspect],
        preload: [:medias]
      )

    Repo.all(query)
  end

  @doc """
  Gets a list of comments by review ids.
  """
  @since "1.0.0"
  @spec get_comments([Integer.t()]) :: [Review.t()] | no_return
  def get_comments(review_ids) do
    query =
      from(
        review in Review,
        where: review.id in ^review_ids,
        join: comments in assoc(review, :comments),
        preload: [comments: comments]
      )

    Repo.all(query)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.
  """
  @since "1.0.0"
  @spec change_review(Review.t()) :: Ecto.Changeset.t()
  def change_review(%Review{} = review) do
    Review.changeset(review, %{})
  end
end
