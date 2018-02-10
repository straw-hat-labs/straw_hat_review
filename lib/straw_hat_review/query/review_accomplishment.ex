defmodule StrawHat.Review.Query.ReviewAccomplishmentQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  @spec get_by(ReviewAccomplishment.t(), Integer.t(), [Integer.t()]) :: Ecto.Query.t()
  def get_by(query, review_id, accomplishment_ids) do
    from(
      review_accomplishmen in query,
      where: review_accomplishmen.review_id == ^review_id,
      where: review_accomplishmen.accomplishment_id in ^accomplishment_ids
    )
  end
end
