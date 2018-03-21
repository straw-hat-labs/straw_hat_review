defmodule StrawHat.Review.Query.ReviewQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  @spec by_ids(Review.t(), [Integer.t()]) :: Ecto.Query.t()
  def by_ids(query, ids) do
    from(review in query,
     where: review.id in ^ids,
     join: reviews in assoc(review, :reviews),
     preload: [reviews: reviews])
  end

  @spec get_tags(Review.t(), [Integer.t()]) :: Ecto.Query.t()
  def get_tags(query, ids) do
    from(review in query,
     where: review.id in ^ids,
     join: tags in assoc(review, :tags),
     preload: [tags: tags])
  end

  @spec get_feedbacks(Review.t(), [Integer.t()]) :: Ecto.Query.t()
  def get_feedbacks(query, ids) do
    from(review in query,
     where: review.id in ^ids,
     join: feedbacks in assoc(review, :feedbacks),
     preload: [feedbacks: feedbacks])
  end

  @spec get_review_aspects(Review.t(), [Integer.t()]) :: Ecto.Query.t()
  def get_review_aspects(query, ids) do
    from(review in query,
     where: review.id in ^ids,
     join: review_aspects in assoc(review, :review_aspects),
     preload: [review_aspects: review_aspects])
  end
end
