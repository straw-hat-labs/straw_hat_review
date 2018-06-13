defmodule StrawHat.Review.ReviewsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.{Reviews, Review}

  describe "find_review/1" do
    test "with valid id" do
      review = insert(:review)

      assert {:ok, _review} = Reviews.find_review(review.id)
    end

    test "with invalid id shouldn't find the review" do
      assert {:error, _reason} = Ecto.UUID.generate() |> Reviews.find_review()
    end
  end

  test "get_reviews/1 list the reviews per page" do
    insert_list(10, :review)
    review = Reviews.get_reviews(%{page: 2, page_size: 5})

    assert length(review.entries) == 5
  end

  describe "create_review/1" do
    test "with valid inputs creates a review" do
      params = review_attrs()
      assert {:ok, _review} = Reviews.create_review(params)
    end
  end

  test "update_review/2 with valid inputs updates a review" do
    review = insert(:review)
    {:ok, review} = Reviews.update_review(review, %{comment: "Awesome!!!"})

    assert review.comment == "Awesome!!!"
  end

  test "get_review_by_ids/1 with valid ids list return the respective reviews" do
    review = insert(:review)
    reviews = Reviews.get_review_by_ids([review.id])

    assert length(reviews) == 1
  end

  test "get_comments/1 with valid ids list return the respective reviews comments" do
    review = insert(:review)
    insert(:comment, review: review)
    reviews = Reviews.get_comments([review.id])

    assert length(Enum.at(reviews, 0).comments) == 1
  end

  test "destroy_review/1 with a found review destroys the review" do
    review = insert(:review)

    assert {:ok, _} = Reviews.destroy_review(review)
  end

  test "change_review/1 returns a review changeset" do
    assert %Ecto.Changeset{} = Reviews.change_review(%Review{})
  end
end
