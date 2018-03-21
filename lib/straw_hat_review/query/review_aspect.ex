defmodule StrawHat.Review.Query.ReviewAspectQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  @spec get_aspects(ReviewAspect.t(), [Integer.t()]) :: Ecto.Query.t()
  def get_aspects(query, ids) do
    from(review_aspect in query,
     where: review_aspect.id in ^ids,
     join: review_aspects in assoc(review_aspect, :review_aspects),
     preload: [review_aspects: review_aspects])
  end

  @spec get_reviews(ReviewAspect.t(), [Integer.t()]) :: Ecto.Query.t()
  def get_reviews(query, ids) do
    from(review_aspect in query,
     where: review_aspect.id in ^ids,
     join: review in assoc(review_aspect, :review),
     preload: [review: review])
  end
end
