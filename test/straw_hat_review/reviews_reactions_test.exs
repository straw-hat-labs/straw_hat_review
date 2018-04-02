defmodule StrawHat.Review.Test.ReviewsReactionsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.ReviewsReactions

  describe "find_review_reaction/1" do
    test "with valid id" do
      reviews_reactions = insert(:reviews_reactions)

      assert {:ok, _reviews_reactions} = ReviewsReactions.find_review_reaction(reviews_reactions.id)
    end

    test "with invalid id shouldn't find the reviews_reactions" do
      assert {:error, _reason} = ReviewsReactions.find_review_reaction(8347)
    end
  end

  test "get_reviews_reactions/1 list the reviews_reactions per page" do
    insert_list(10, :reviews_reactions)
    reviews_reactions = ReviewsReactions.get_reviews_reactions(%{page: 2, page_size: 5})

    assert length(reviews_reactions.entries) == 5
  end

  test "create_reviews_reactions/1 with valid inputs creates a reviews_reactions" do
    review = insert(:review)
    reaction = insert(:reaction)
    params = params_for(:reviews_reactions, review: review, reaction: reaction)

    assert {:ok, _reviews_reactions} = ReviewsReactions.create_reviews_reactions(params)
  end

  test "update_reviews_reactions/2 with valid inputs updates a reviews_reactions" do
    reviews_reactions = insert(:reviews_reactions)
    {:ok, reviews_reactions} = ReviewsReactions.update_reviews_reactions(reviews_reactions, %{user_id: "user:546"})

    assert reviews_reactions.user_id == "user:546"
  end

  test "destroy_reviews_reactions/1 with a found review destroys the reviews_reactions" do
    reviews_reactions = insert(:reviews_reactions)

    assert {:ok, _} = ReviewsReactions.destroy_reviews_reactions(reviews_reactions)
  end
end
