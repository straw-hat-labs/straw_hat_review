defmodule StrawHat.Review.Test.AspectTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Aspect

  test "get aspect by id" do
    aspect = insert(:aspect)
    assert Aspect.get_aspect(aspect.id) != nil
  end

  test "get aspect with invalid id" do
    assert {:error, _reason} = Aspect.find_aspect(836_747)
  end

  test "list per page" do
    insert_list(10, :aspect)
    aspect = Aspect.get_aspects(%{page: 2, page_size: 5})
    assert aspect.total_entries == 10
  end

  test "create aspect" do
    params = params_for(:aspect)
    assert {:ok, _aspect} = Aspect.create_aspect(params)
  end

  test "update aspect" do
    aspect = insert(:aspect)

    {:ok, aspect} =
      Aspect.update_aspect(aspect, %{name: "Professional"})

    assert aspect.name == "Professional"
  end

  test "delete aspect" do
    aspect = insert(:aspect)
    assert {:ok, _} = Aspect.destroy_aspect(aspect)
  end
end
