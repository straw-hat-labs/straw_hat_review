defmodule StrawHat.Review.Test.CommentsReactionsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.CommentsReactions

  describe "find_comment_reaction/1" do
    test "with valid id" do
      comments_reactions = insert(:comments_reactions)

      assert {:ok, _comments_reactions} = CommentsReactions.find_comment_reaction(comments_reactions.id)
    end

    test "with invalid id shouldn't find the comments_reactions" do
      assert {:error, _reason} = CommentsReactions.find_comment_reaction(8347)
    end
  end

  test "get_comments_reactions/1 list the comments_reactions per page" do
    insert_list(10, :comments_reactions)
    comments_reactions = CommentsReactions.get_comments_reactions(%{page: 2, page_size: 5})

    assert length(comments_reactions.entries) == 5
  end

  test "create_comments_reactions/1 with valid inputs creates a comments_reactions" do
    comment = insert(:comment)
    reaction = insert(:reaction)
    params = params_for(:comments_reactions, comment: comment, reaction: reaction)

    assert {:ok, _comments_reactions} = CommentsReactions.create_comments_reactions(params)
  end

  test "update_comments_reactions/2 with valid inputs updates a comments_reactions" do
    comments_reactions = insert(:comments_reactions)
    {:ok, comments_reactions} = CommentsReactions.update_comments_reactions(comments_reactions, %{user_id: "user:546"})

    assert comments_reactions.user_id == "user:546"
  end

  test "destroy_comments_reactions/1 with a found review destroys the comments_reactions" do
    comments_reactions = insert(:comments_reactions)

    assert {:ok, _} = CommentsReactions.destroy_comments_reactions(comments_reactions)
  end
end
