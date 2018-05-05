defmodule StrawHat.Review.ReviewReactionsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.ReviewReactions

  describe "find_review_reaction/1" do
    test "with valid id" do
      review_reaction = insert(:review_reaction)

      assert {:ok, _review_reaction} = ReviewReactions.find_review_reaction(review_reaction.id)
    end

    test "with invalid id shouldn't find the review_reaction" do
      assert {:error, _reason} = ReviewReactions.find_review_reaction(8347)
    end
  end

  test "create_review_reaction/1 with valid inputs creates a review_reaction" do
    params = params_with_assocs(:review_reaction)

    assert {:ok, _review_reaction} = ReviewReactions.create_review_reaction(params)
  end

  test "update_review_reaction/2 with valid inputs updates a review_reaction" do
    review_reaction = insert(:review_reaction)

    {:ok, review_reaction} =
      ReviewReactions.update_review_reaction(review_reaction, %{user_id: "user:546"})

    assert review_reaction.user_id == "user:546"
  end

  test "destroy_review_reaction/1 with a found review destroys the review_reaction" do
    review_reaction = insert(:review_reaction)

    assert {:ok, _} = ReviewReactions.destroy_review_reaction(review_reaction)
  end
end
