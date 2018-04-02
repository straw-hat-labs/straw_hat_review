defmodule StrawHat.Review.Reviews do
  @moduledoc """
  Interactor module that defines all the functionality for Reviews management.
  """

  use StrawHat.Review.Interactor

  import Ecto.Query, only: [from: 2]
  alias StrawHat.Review.{Review, Attachment}

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
    review_attrs = put_reviews_aspects_to_attributes(review_attrs)

    %Review{}
    |> Review.changeset(review_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a review.
  """
  @since "1.0.0"
  @spec update_review(Review.t(), Review.review_attrs()) ::
          {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def update_review(%Review{} = review, review_attrs) do
    review_attrs = put_reviews_aspects_to_attributes(review_attrs)
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

  # @doc """
  # Add attachment to review.
  # """
  # @since "1.0.0"
  # @spec add_attachment(Review.t(), String.t() | Plug.Upload.t() | Map.t() ) :: {:ok, String.t()} | {:error, Error.t()} | {:error, String.t()}
  # def add_attachment(review, file) do
  #   AttachmentFile.store({file, review})
  # end

  # @doc """
  # Remove attachment from review.
  # """
  # @since "1.0.0"
  # @spec remove_attachment(Review.t(), String.t() | Map.t()) :: :ok
  # def remove_attachment(review, path) do
  #   AttachmentFile.delete({path, review})
  # end

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
  @spec put_reviews_aspects_to_attributes(Review.review_attrs()) :: [Tag.t()]
  # defp put_reviews_aspects_to_attributes(%{reviews_aspects: reviews_aspects} = review_attrs) do
  #   tags =
  #     reviews_aspects
  #     |> String.split(",")
  #     |> Enum.map(&String.trim/1)
  #     |> Enum.reject(& &1 == "")
  #     |> Enum.map(&get_or_insert_tag/1)
  #   Map.put(review_attrs, :tags, tags)
  # end
  defp put_reviews_aspects_to_attributes(review_attrs) do
    review_attrs
  end

  # @since "1.0.0"
  # @spec get_or_insert_tag(String.t()) :: Tag.t()
  # defp get_or_insert_tag(name) do
  #   Repo.get_by(Tag, name: name) ||
  #   Repo.insert!(%Tag{name: name})
  # end
end
