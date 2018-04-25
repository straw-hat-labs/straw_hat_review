defmodule StrawHat.Review.Reviews do
  @moduledoc """
  Interactor module that defines all the functionality for Reviews management.
  """

  use StrawHat.Review.Interactor
  alias StrawHat.Response
  alias StrawHat.Review.{Review, Medias, ReviewAspect, ReviewReaction}

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
    %Review{}
    |> Review.changeset(review_attrs)
    |> Repo.insert()
    |> Response.and_then(fn review ->
      review
      |> put_aspects(review_attrs)
      |> put_medias(review_attrs)
    end)
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
    |> Response.and_then(fn review ->
      review
      |> put_aspects(review_attrs)
      |> put_medias(review_attrs)
    end)
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
    query = from(review in Review, where: review.id in ^review_ids)

    Repo.all(query)
  end

  @doc """
  Get list of medias by review ids.
  """
  @since "1.0.0"
  @spec get_medias([Integer.t()]) :: [Review.t()] | no_return
  def get_medias(review_ids) do
    query =
      from(
        review in Review,
        where: review.id in ^review_ids,
        join: medias in assoc(review, :medias),
        preload: [medias: medias]
      )

    Repo.all(query)
  end

  @doc """
  Get list of reviews aspects by review ids.
  """
  @since "1.0.0"
  @spec get_reviews_aspects([Integer.t()]) :: [Review.t()] | no_return
  def get_reviews_aspects(review_ids) do
    query =
      from(
        review in Review,
        where: review.id in ^review_ids,
        join: reviews_aspects in assoc(review, :reviews_aspects),
        preload: [reviews_aspects: reviews_aspects]
      )

    Repo.all(query)
  end

  @doc """
  Get list of comments by review ids.
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
  Get list of reviews reactions by review ids.
  """
  @since "1.0.0"
  @spec get_reviews_reactions([Integer.t()]) :: [Review.t()] | no_return
  def get_reviews_reactions(review_ids) do
    query =
      from(
        review in Review,
        where: review.id in ^review_ids,
        join: reviews_reactions in assoc(review, :reviews_reactions),
        preload: [reviews_reactions: reviews_reactions]
      )

    Repo.all(query)
  end

  @since "1.0.0"
  @spec add_reaction(Integer.t(), String.t(), Integer.t()) ::
          {:ok, ReviewReaction.t()} | {:error, Ecto.Changeset.t()}
  def add_reaction(review_id, user_id, reaction_id) do
    changes = %{reaction_id: reaction_id}

    review_reaction =
      case Repo.get_by(ReviewReaction, review_id: review_id, user_id: user_id) do
        nil -> %ReviewReaction{review_id: review_id, user_id: user_id}
        review_reaction -> review_reaction
      end

    review_reaction
    |> ReviewReaction.changeset(changes)
    |> Repo.insert_or_update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.
  """
  @since "1.0.0"
  @spec change_review(Review.t()) :: Ecto.Changeset.t()
  def change_review(%Review{} = review) do
    Review.changeset(review, %{})
  end

  @since "1.0.0"
  @spec put_aspects(Review.t(), Review.review_attrs()) :: {:ok, Review.t()}
  defp put_aspects(review, %{aspects: aspects}) do
    reviews_aspects =
      Enum.reduce(aspects, [], fn aspect, acc ->
        {_, aspect} = create_review_aspect(review.id, aspect)
        [aspect | acc]
      end)

    Map.put(review, :reviews_aspects, reviews_aspects)
  end

  defp put_aspects(review, _), do: review

  @since "1.0.0"
  @spec put_medias(Review.t(), Review.review_attrs()) :: {:ok, Review.t()}
  defp put_medias(review, %{medias: medias}) do
    medias =
      Enum.reduce(medias, [], fn media, acc ->
        {_, media} = create_media(review.id, media)
        [media | acc]
      end)

    review = Map.put(review, :medias, medias)
    {:ok, review}
  end

  defp put_medias(review, _) do
    {:ok, review}
  end

  @since "1.0.0"
  @spec create_review_aspect(Integer.t(), Map.t()) ::
          {:ok, ReviewAspect.t()} | {:error, Ecto.Changeset.t()}
  defp create_review_aspect(review_id, review_aspect_attrs) do
    review_aspect_attrs = Map.put(review_aspect_attrs, :review_id, review_id)

    %ReviewAspect{}
    |> ReviewAspect.changeset(review_aspect_attrs)
    |> Repo.insert()
  end

  @since "1.0.0"
  @spec create_media(Integer.t(), Map.t()) :: {:ok, Media.t()} | {:error, Ecto.Changeset.t()}
  defp create_media(review_id, media) do
    media
    |> Map.put(:review_id, review_id)
    |> Medias.create_media()
  end
end
