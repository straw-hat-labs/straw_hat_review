defmodule StrawHat.Review.Test.FeedbackTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Feedback

  test "get feedback by id" do
    feedback = insert(:feedback)
    assert Feedback.get_feedback(feedback.id) != nil
  end

  test "get feedback with invalid id" do
    assert {:error, _reason} = Feedback.find_feedback(836_747)
  end

  test "list per page" do
    insert_list(10, :feedback)
    feedback = Feedback.get_feedbacks(%{page: 2, page_size: 5})
    assert feedback.total_entries == 10
  end

  test "create feedback" do
    review = insert(:review)
    params = params_for(:feedback, %{review_id: review.id})
    assert {:ok, _feedback} = Feedback.create_feedback(params)
  end

  test "update feedback" do
    feedback = insert(:feedback)
    {:ok, feedback} = Feedback.update_feedback(feedback, %{type: "Recommended"})
    assert feedback.type == "Recommended"
  end

  test "delete feedback" do
    feedback = insert(:feedback)
    assert {:ok, _} = Feedback.destroy_feedback(feedback)
  end
end
