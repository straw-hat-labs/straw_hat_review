defmodule StrawHat.Review.Test.RecommendationTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Recommendation

  test "get recommendation by id" do
    recommendation = insert(:recommendation)
    assert Recommendation.get_recommendation(recommendation.id) != nil
  end

  test "get recommendation with invalid id" do
    assert {:error, _reason} = Recommendation.find_recommendation(836_747)
  end

  test "list per page" do
    insert_list(10, :recommendation)
    recommendation = Recommendation.get_recommendations(%{page: 2, page_size: 5})
    assert recommendation.total_entries == 10
  end

  test "create recommendation" do
    review = insert(:review)
    params = params_for(:recommendation, %{review_id: review.id})
    assert {:ok, _recommendation} = Recommendation.create_recommendation(params)
  end

  test "update recommendation" do
    recommendation = insert(:recommendation)
    {:ok, recommendation} = Recommendation.update_recommendation(recommendation, %{type: "Recommended"})
    assert recommendation.type == "Recommended"
  end

  test "delete recommendation" do
    recommendation = insert(:recommendation)
    assert {:ok, _} = Recommendation.destroy_recommendation(recommendation)
  end
end
