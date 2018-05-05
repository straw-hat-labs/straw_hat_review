defmodule StrawHat.Review.CommentReactionsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.CommentReactions

  describe "find_comment_reaction/1" do
    test "with valid id" do
      comments_reactions = insert(:comments_reactions)

      assert {:ok, _comments_reactions} =
               CommentReactions.find_comment_reaction(comments_reactions.id)
    end

    test "with invalid id shouldn't find the comments_reactions" do
      assert {:error, _reason} = CommentReactions.find_comment_reaction(8347)
    end
  end

  test "get_comment_reactions/1 list the comments_reactions per page" do
    insert_list(10, :comments_reactions)
    comments_reactions = CommentReactions.get_comment_reactions(%{page: 2, page_size: 5})

    assert length(comments_reactions.entries) == 5
  end

  test "create_comment_reaction/1 with valid inputs creates a comments_reactions" do
    comment = insert(:comment)
    reaction = insert(:reaction)
    params = params_for(:comments_reactions, comment: comment, reaction: reaction)

    assert {:ok, _comments_reactions} = CommentReactions.create_comment_reaction(params)
  end

  test "update_comment_reaction/2 with valid inputs updates a comments_reactions" do
    comments_reactions = insert(:comments_reactions)

    {:ok, comments_reactions} =
      CommentReactions.update_comment_reaction(comments_reactions, %{user_id: "user:546"})

    assert comments_reactions.user_id == "user:546"
  end

  test "destroy_comment_reaction/1 with a found review destroys the comments_reactions" do
    comments_reactions = insert(:comments_reactions)

    assert {:ok, _} = CommentReactions.destroy_comment_reaction(comments_reactions)
  end
end
