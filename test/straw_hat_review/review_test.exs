defmodule StrawHat.Review.Test.ReviewsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Reviews

  describe "find_review/1" do
    test "with valid id" do
      review = insert(:review)

      assert {:ok, _review} = Reviews.find_review(review.id)
    end

    test "with invalid id shouldn't find the review" do
      assert {:error, _reason} = Reviews.find_review(8347)
    end
  end

  test "get_reviews/1 list the reviews per page" do
    insert_list(10, :review)
    review = Reviews.get_reviews(%{page: 2, page_size: 5})

    assert length(review.entries) == 5
  end

  describe "create_review/1" do

    test "with valid inputs creates a review" do
      params = params_for(:review)

      assert {:ok, _review} = Reviews.create_review(params)
    end

    test "with valid inputs creates a review with aspect" do
      aspect = insert(:aspect)

      params = 
        :review
        |> params_for()
        |> Map.put(:aspects, [%{score: 3, aspect_id: aspect.id}])

      assert {:ok, review} = Reviews.create_review(params)
      assert length(review.reviews_aspects) == 1
    end
  end

  test "update_review/2 with valid inputs updates a review" do
    review = insert(:review)
    {:ok, review} = Reviews.update_review(review, %{comment: "Awesome!!!"})

    assert review.comment == "Awesome!!!"
  end

  test "destroy_review/1 with a found review destroys the review" do
    review = insert(:review)

    assert {:ok, _} = Reviews.destroy_review(review)
  end
end
