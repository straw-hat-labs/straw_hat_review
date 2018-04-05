defmodule StrawHat.Review.Reviews do
  @moduledoc """
  Interactor module that defines all the functionality for Reviews management.
  """

  use StrawHat.Review.Interactor

  import Ecto.Query, only: [from: 2]
  alias StrawHat.Review.{Review, Attachments, ReviewAspect}

  @doc """
  Get the list of reviews.
  """
  @since "1.0.0"
  @spec get_reviews(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_reviews(pagination \\ []), do: Repo.paginate(Review, pagination)

  @doc """
  Create a review.
  """
  @since "1.0.0"
  @spec create_review(Review.review_attrs()) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def create_review(review_attrs) do
    result =
      %Review{}
      |> Review.changeset(review_attrs)
      |> Repo.insert()

    with {:ok, review} <- result do
      review
      |> put_aspects(review_attrs)
      |> put_attachments(review_attrs)
    end
  end

  @doc """
  Update a review.
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
  Destroy a review.
  """
  @since "1.0.0"
  @spec destroy_review(Review.t()) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def destroy_review(%Review{} = review), do: Repo.delete(review)

  @doc """
  Find a review by `id`.
  """
  @since "1.0.0"
  @spec find_review(Integer.t()) :: {:ok, Review.t()} | {:error, Error.t()}
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
  @since "1.0.0"
  @spec get_review(Integer.t()) :: Review.t() | nil | no_return
  def get_review(review_id), do: Repo.get(Review, review_id)

  @doc """
  Get list of review by ids.
  """
  @since "1.0.0"
  @spec review_by_ids([Integer.t()]) :: [Review.t()] | no_return
  def review_by_ids(review_ids) do
    query =
      from(review in Review,
        where: review.id in ^review_ids)

    query
    |> Repo.all()
    |> Repo.preload(:reviews)
  end

  @doc """
  Get list of reviews aspects by review ids.
  """
  @since "1.0.0"
  @spec get_reviews_aspects([Integer.t()]) :: [Review.t()] | no_return
  def get_reviews_aspects(review_ids) do
    query = 
      from(review in Review,
        where: review.id in ^review_ids,
        join: reviews_aspects in assoc(review, :reviews_aspects),
        preload: [reviews_aspects: reviews_aspects])

    Repo.all(query)
  end

  @doc """
  Get list of comments by review ids.
  """
  @since "1.0.0"
  @spec get_comments([Integer.t()]) :: [Review.t()] | no_return
  def get_comments(review_ids) do
    query =
      from(review in Review,
        where: review.id in ^review_ids,
        join: comments in assoc(review, :comments),
        preload: [comments: comments])

     Repo.all(query)
  end

  @doc """
  Get list of reviews reactions by review ids.
  """
  @since "1.0.0"
  @spec get_reviews_reactions([Integer.t()]) :: [Review.t()] | no_return
  def get_reviews_reactions(review_ids) do
    query =
      from(review in Review,
        where: review.id in ^review_ids,
        join: reviews_reactions in assoc(review, :reviews_reactions),
        preload: [reviews_reactions: reviews_reactions])

     Repo.all(query)
  end

  @since "1.0.0"
  @spec put_aspects(Review.t(), Review.review_attrs()) :: {:ok, Review.t()}
  defp put_aspects(review, %{aspects: aspects}) do    
    reviews_aspects =
      Enum.reduce(aspects, [], fn(aspect, acc) ->
        {_, aspect} = create_review_aspect(review.id, aspect)
        [aspect | acc]
      end)

    Map.put(review, :reviews_aspects, reviews_aspects)
  end
  defp put_aspects(review, _), do: review

  @since "1.0.0"
  @spec put_attachments(Review.t(), Review.review_attrs()) :: {:ok, Review.t()}
  defp put_attachments(review, %{attachments: attachments}) do
    attachments =
      Enum.reduce(attachments, [], fn(attachment, acc) ->
        {_, attachment} = create_attachment(review.id, attachment)
        [attachment | acc]
      end)

    review = Map.put(review, :attachments, attachments)
    {:ok, review}
  end
  defp put_attachments(review, _) do
    {:ok, review}
  end

  @since "1.0.0"
  @spec create_review_aspect(Integer.t(), Map.t()) :: {:ok, ReviewAspect.t()} | {:error, Ecto.Changeset.t()}
  defp create_review_aspect(review_id, review_aspect_attrs) do
    review_aspect_attrs = Map.put(review_aspect_attrs, :review_id, review_id)

    %ReviewAspect{}
    |> ReviewAspect.changeset(review_aspect_attrs)
    |> Repo.insert()
  end

  @since "1.0.0"
  @spec create_attachment(Integer.t(), Map.t()) :: {:ok, Attachment.t()} | {:error, Ecto.Changeset.t()}
  defp create_attachment(review_id, attachment) do
    attachment
    |> Map.put(:review_id, review_id)
    |> Attachments.create_attachment()
  end
end
