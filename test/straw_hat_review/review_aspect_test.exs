defmodule StrawHat.Review.Test.ReviewAspectTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.ReviewAspects

  describe "find_review_aspect/1" do
    test "with valid id" do
      review_aspect = insert(:review_aspect)

      assert {:ok, _review_aspect} = ReviewAspects.find_review_aspect(review_aspect.id)
    end

    test "with invalid id shouldn't find the review" do
      assert {:error, _reason} = ReviewAspects.find_review_aspect(8367)
    end
  end

  test "get_review_aspects/1 list the review aspects per page" do
    insert_list(10, :review_aspect)
    review_aspect = ReviewAspects.get_review_aspects(%{page: 2, page_size: 5})

    assert length(review_aspect.entries) == 5
  end

  test "create_review_aspect/1 with valid inputs creates a review aspect" do
    review = insert(:review)
    aspect = insert(:aspect)
    params = params_for(:review_aspect,%{aspect_id: aspect.id, review_id: review.id})

    assert {:ok, _review_aspect} = ReviewAspects.create_review_aspect(params)
  end

  test "update_review_aspect/2 with valid inputs updates a review aspect" do
    review_aspect = insert(:review_aspect)
    {:ok, review_aspect} = ReviewAspects.update_review_aspect(review_aspect, %{comment: "Recommended"})

    assert review_aspect.comment == "Recommended"
  end

  test "get_reviews/1 with a list of IDs returns the relative review aspect with the associated review" do
    review_aspect = insert(:review_aspect)
    review_aspects = ReviewAspects.get_reviews([review_aspect.id])
    review = Enum.at(review_aspects, 0).review

    assert length(review_aspects) == 1
    assert review.id == review_aspect.review_id
  end

  test "get_aspects/1 with a list of IDs returns the relative review aspect with the associated aspect" do
    review_aspect = insert(:review_aspect)
    review_aspects = ReviewAspects.get_aspects([review_aspect.id])
    aspect = Enum.at(review_aspects, 0).aspect

    assert length(review_aspects) == 1
    assert aspect.id == review_aspect.aspect_id
  end

  test "destroy_review_aspect/1 with a found review aspect destroys the aspect" do
    review_aspect = insert(:review_aspect)

    assert {:ok, _} = ReviewAspects.destroy_review_aspect(review_aspect)
  end
end
