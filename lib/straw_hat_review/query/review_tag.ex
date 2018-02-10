defmodule StrawHat.Review.Query.ReviewTagQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  @spec get_by(ReviewTag.t(), Integer.t(), [Integer.t()]) :: Ecto.Query.t()
  def get_by(query, review_id, tag_ids) do
    from(
      review_tag in query,
      where: review_tag.review_id == ^review_id,
      where: review_tag.tag_id in ^tag_ids
    )
  end
end
