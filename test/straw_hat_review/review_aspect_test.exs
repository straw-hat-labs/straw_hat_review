defmodule StrawHat.Review.Test.ReviewAspectTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.ReviewAspect

  test "get review aspect by id" do
    review_aspect = insert(:review_aspect)
    assert ReviewAspect.get_review_aspect(review_aspect.id) != nil
  end

  test "get review aspect with invalid id" do
    assert {:error, _reason} = ReviewAspect.find_review_aspect(836_747)
  end

  test "list per page" do
    insert_list(10, :review_aspect)
    review_aspect = ReviewAspect.get_review_aspects(%{page: 2, page_size: 5})
    assert review_aspect.total_entries == 10
  end

  test "create review aspect" do
    review = insert(:review)
    aspect = insert(:aspect)
    params = params_for(:review_aspect,%{aspect_id: aspect.id, review_id: review.id})
    assert {:ok, _review_aspect} = ReviewAspect.create_review_aspect(params)
  end

  test "update review aspect" do
    review_aspect = insert(:review_aspect)
    {:ok, review_aspect} = ReviewAspect.update_review_aspect(review_aspect, %{comment: "Recommended"})
    assert review_aspect.comment == "Recommended"
  end

  test "delete review aspect" do
    review_aspect = insert(:review_aspect)
    assert {:ok, _} = ReviewAspect.destroy_review_aspect(review_aspect)
  end
end
