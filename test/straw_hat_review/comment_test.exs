defmodule StrawHat.Review.CommentsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.{Comments, Comment}

  describe "find_comment/1" do
    test "with valid id" do
      comment = insert(:comment)

      assert {:ok, _comment} = Comments.find_comment(comment.id)
    end

    test "with invalid id shouldn't find the comment" do
      assert {:error, _reason} = Comments.find_comment(8347)
    end
  end

  test "get_comments/1 list the comments per page" do
    insert_list(10, :comment)
    comment = Comments.get_comments(%{page: 2, page_size: 5})

    assert length(comment.entries) == 5
  end

  test "create_comment/1 with valid inputs creates a comment" do
    review = insert(:review)
    params = params_for(:comment, review: review)

    assert {:ok, _comment} = Comments.create_comment(params)
  end

  test "update_comment/2 with valid inputs updates a comment" do
    comment = insert(:comment)
    {:ok, comment} = Comments.update_comment(comment, %{comment: "Awesome!!"})

    assert comment.comment == "Awesome!!"
  end

  test "comment_by_ids/1 with valid ids list return the respective comments" do
    comment = insert(:comment)
    comments = Comments.comment_by_ids([comment.id])

    assert length(comments) == 1
  end

  test "destroy_comment/1 with a found review destroys the comment" do
    comment = insert(:comment)

    assert {:ok, _} = Comments.destroy_comment(comment)
  end

  test "change_comment/1 returns a comment changeset" do
    assert %Ecto.Changeset{} = Comments.change_comment(%Comment{})
  end
end
