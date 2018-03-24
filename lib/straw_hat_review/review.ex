defmodule StrawHat.Review.Review do
  @moduledoc """
  Interactor module that defines all the functionality for Review management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.{Review, ReviewTag, Tag}
  alias StrawHat.Review.Query.{ReviewQuery, ReviewTagQuery}

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
    |> Ecto.Changeset.put_assoc(:tags, parse_tags(review_attrs))
    |> Repo.insert()
  end

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
  @spec destroy_review(Review.t()) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def destroy_review(%Review{} = review), do: Repo.delete(review)

  @doc """
  Find a review by `id`.
  """
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
  @spec get_review(Integer.t()) :: Review.t() | nil | no_return
  def get_review(review_id), do: Repo.get(Review, review_id)

  @doc """
  Add tags to review.
  """
  @spec add_tags(Review.t(), [Tag.t()]) :: {:ok, Review.t()} | {:error, Ecto.Changeset.t()}
  def add_tags(review, tags) do
    review
    |> Repo.preload(:tags)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:tags, tags)
    |> Repo.update()
  end

  @doc """
  Remove tags from review.
  """
  @spec remove_tags(Review.t(), [Integer.t()]) :: {integer, nil | [term]} | no_return
  def remove_tags(review, tags) do
    ReviewTag
    |> ReviewTagQuery.get_by(review.id, tags)
    |> Repo.delete_all()
  end

  @doc """
  Get list of review by ids.
  """
  @spec review_by_ids([Integer.t()]) :: [Review.t()] | no_return
  def review_by_ids(review_ids) do
    Review
    |> ReviewQuery.by_ids(review_ids)
    |> Repo.all()
  end

  @doc """
  Get list of tag by review ids.
  """
  @spec get_tags([Integer.t()]) :: [Review.t()] | no_return
  def get_tags(review_ids) do
    Review
    |> ReviewQuery.get_tags(review_ids)
    |> Repo.all()
  end

  @doc """
  Get list of feedbacks by review ids.
  """
  @spec get_feedbacks([Integer.t()]) :: [Review.t()] | no_return
  def get_feedbacks(review_ids) do
    Review
    |> ReviewQuery.get_feedbacks(review_ids)
    |> Repo.all()
  end

  @doc """
  Get list of review aspects by review ids.
  """
  @spec get_review_aspects([Integer.t()]) :: [Review.t()] | no_return
  def get_review_aspects(review_ids) do
    Review
    |> ReviewQuery.get_review_aspects(review_ids)
    |> Repo.all()
  end

  defp parse_tags(params) do
    (params[:tags] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> Enum.map(&get_or_insert_tag/1)
  end

  defp get_or_insert_tag(name) do
    Repo.get_by(Tag, name: name) ||
    Repo.insert!(%Tag{name: name})
  end
end
