defmodule StrawHat.Review.Test.ReviewTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Reviews

  describe "find_review/1" do
    test "with valid id" do
      review = insert(:review)

      assert {:ok, _review} = Reviews.find_review(review.id)
    end

    test "with invalid id shouldn't find the review" do
      assert {:error, _reason} = Reviews.find_review(8367)
    end
  end

  test "get_reviews/1 list the reviews per page" do
    insert_list(10, :review)
    review = Reviews.get_reviews(%{page: 2, page_size: 5})

    assert review.total_entries == 10
  end

  describe "create_review/1" do
    test "with valid inputs creates a review" do
      params = params_for(:review)

      assert {:ok, _review} = Reviews.create_review(params)
    end

    test "with valid inputs creates a review with tags" do
      params = 
        :review
        |> params_for()
        |> Map.put(:tags, "Nails,Thumb,Blesser")

      assert {:ok, review} = Reviews.create_review(params)
      assert length(review.tags) == 3
    end
  end

  describe "update_review/2" do
    test "with valid inputs updates a review" do
      review = insert(:review)
      {:ok, review} = Reviews.update_review(review, %{score: 4})

      assert review.score == 4
    end

    test "with valid inputs updates a review with tags" do
      params = 
        :review
        |> params_for()
        |> Map.put(:tags, "Nails,Thumb,Blesser")
      
      assert {:ok, review} = Reviews.create_review(params)
      assert {:ok, review} = Reviews.update_review(review, %{tags: "Bummble"})
      assert length(review.tags) == 1
    end
  end

  test "destroy_review/1 with a found review destroys the review" do
    review = insert(:review)

    assert {:ok, _} = Reviews.destroy_review(review)
  end

  test "review_by_ids/1 with a list of IDs returns the relative reviews" do
    review = insert(:review)
    reviews = Reviews.review_by_ids([review.id])

    assert length(reviews) == 1
  end

  test "get_tags/1 with a list of IDs returns the relative reviews with tags" do
    review_tag = insert(:review_tag)
    reviews = Reviews.get_tags([review_tag.review_id])
    review = Enum.at(reviews, 0)

    assert length(reviews) == 1  
    assert length(review.tags) == 1
  end

  test "get_feedbacks/1 with a list of IDs returns the relative reviews with feedbacks" do
    feedback = insert(:feedback)
    reviews = Reviews.get_feedbacks([feedback.review_id])
    review = Enum.at(reviews, 0)

    assert length(reviews) == 1  
    assert length(review.feedbacks) == 1
  end

  test "get_review_aspects/1 with a list of IDs returns the relative reviews with aspects" do
    review_aspect = insert(:review_aspect)
    reviews = Reviews.get_review_aspects([review_aspect.review_id])
    review = Enum.at(reviews, 0)

    assert length(reviews) == 1  
    assert length(review.review_aspects) == 1
  end
end
