defmodule StrawHat.Review.Test.FeedbacksTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Feedbacks

  describe "find_feedback/1" do
    test "with valid id" do
      feedback = insert(:feedback)

      assert {:ok, _feedback} = Feedbacks.find_feedback(feedback.id)
    end

    test "with invalid id shouldn't find the feedback" do
      assert {:error, _reason} = Feedbacks.find_feedback(8347)
    end
  end

  test "get_feedbacks/1 list the feedbacks per page" do
    insert_list(10, :feedback)
    feedback = Feedbacks.get_feedbacks(%{page: 2, page_size: 5})

    assert feedback.total_entries == 10
  end

  test "create_feedback/1 with valid inputs creates a feedback" do
    review = insert(:review)
    params = params_for(:feedback, %{review_id: review.id})

    assert {:ok, _feedback} = Feedbacks.create_feedback(params)
  end

  test "update_feedback/2 with valid inputs updates a feedback" do
    feedback = insert(:feedback)
    {:ok, feedback} = Feedbacks.update_feedback(feedback, %{user_id: "user:4589"})

    assert feedback.user_id == "user:4589"
  end

  test "destroy_feedback/1 with a found review destroys the feedback" do
    feedback = insert(:feedback)

    assert {:ok, _} = Feedbacks.destroy_feedback(feedback)
  end
end
