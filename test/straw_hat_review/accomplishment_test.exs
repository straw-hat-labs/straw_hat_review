defmodule StrawHat.Review.Test.AccomplishmentTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Accomplishment

  test "get accomplishment by id" do
    accomplishment = insert(:accomplishment)
    assert Accomplishment.get_accomplishment(accomplishment.id) != nil
  end

  test "get accomplishment with invalid id" do
    assert {:error, _reason} = Accomplishment.find_accomplishment(836_747)
  end

  test "list per page" do
    insert_list(10, :accomplishment)
    accomplishment = Accomplishment.get_accomplishments(%{page: 2, page_size: 5})
    assert accomplishment.total_entries == 10
  end

  test "create accomplishment" do
    params = params_for(:accomplishment)
    assert {:ok, _accomplishment} = Accomplishment.create_accomplishment(params)
  end

  test "update accomplishment" do
    accomplishment = insert(:accomplishment)

    {:ok, accomplishment} =
      Accomplishment.update_accomplishment(accomplishment, %{name: "Professional"})

    assert accomplishment.name == "Professional"
  end

  test "delete accomplishment" do
    accomplishment = insert(:accomplishment)
    assert {:ok, _} = Accomplishment.destroy_accomplishment(accomplishment)
  end
end
