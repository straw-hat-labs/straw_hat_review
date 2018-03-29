defmodule StrawHat.Review.AspectsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Aspects

  describe "find_aspect/1" do
    test "with valid id" do
      aspect = insert(:aspect)

      assert {:ok, _aspect} = Aspects.find_aspect(aspect.id)
    end

    test "with invalid id shouldn't find the aspect" do
      assert {:error, _reason} = Aspects.find_aspect(8347)
    end
  end

  test "get_aspects/1 list the aspects per page" do
    insert_list(10, :aspect)
    aspect = Aspects.get_aspects(%{page: 2, page_size: 5})

    assert length(aspect.entries) == 5
  end

  test "create_aspect/1 with valid inputs creates a aspect" do
    params = params_for(:aspect)

    assert {:ok, _aspect} = Aspects.create_aspect(params)
  end

  test "update_aspect/2 with valid inputs updates a aspect" do
    aspect = insert(:aspect)
    {:ok, aspect} = Aspects.update_aspect(aspect, %{name: "Professional"})

    assert aspect.name == "Professional"
  end

  test "destroy_aspect/1 with a found review destroys the aspect" do
    aspect = insert(:aspect)

    assert {:ok, _} = Aspects.destroy_aspect(aspect)
  end
end
