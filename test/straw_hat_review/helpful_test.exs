defmodule StrawHat.Review.Test.HelpfulTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Helpful

  test "get helpful by id" do
    helpful = insert(:helpful)
    assert Helpful.get_helpful(helpful.id) != nil
  end

  test "get helpful with invalid id" do
    assert {:error, _reason} = Helpful.find_helpful(836_747)
  end

  test "list per page" do
    insert_list(10, :helpful)
    helpful = Helpful.get_helpfuly(%{page: 2, page_size: 5})
    assert helpful.total_entries == 10
  end

  test "create helpful" do
    review = insert(:review)
    params = params_for(:helpful, %{review_id: review.id})
    assert {:ok, _helpful} = Helpful.create_helpful(params)
  end

  test "update helpful" do
    helpful = insert(:helpful)
    {:ok, helpful} = Helpful.update_helpful(helpful, %{classification: "Recommended"})
    assert helpful.classification == "Recommended"
  end

  test "delete helpful" do
    helpful = insert(:helpful)
    assert {:ok, _} = Helpful.destroy_helpful(helpful)
  end
end
