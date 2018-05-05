defmodule StrawHat.Review.ReviewReactionsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.ReviewReactions

  describe "find_reviews_reactions/1" do
    test "with valid id" do
      reviews_reactions = insert(:reviews_reactions)

      assert {:ok, _reviews_reactions} =
               ReviewReactions.find_reaction(reviews_reactions.id)
    end

    test "with invalid id shouldn't find the reviews_reactions" do
      assert {:error, _reason} = ReviewReactions.find_reaction(8347)
    end
  end

  test "create_reviews_reactions/1 with valid inputs creates a reviews_reactions" do
    params = params_with_assocs(:reviews_reactions)

    assert {:ok, _reviews_reactions} = ReviewReactions.create_reaction(params)
  end

  test "update_reviews_reactions/2 with valid inputs updates a reviews_reactions" do
    reviews_reactions = insert(:reviews_reactions)

    {:ok, reviews_reactions} =
      ReviewReactions.update_reaction(reviews_reactions, %{user_id: "user:546"})

    assert reviews_reactions.user_id == "user:546"
  end

  test "destroy_reviews_reactions/1 with a found review destroys the reviews_reactions" do
    reviews_reactions = insert(:reviews_reactions)

    assert {:ok, _} = ReviewReactions.destroy_reaction(reviews_reactions)
  end
end
