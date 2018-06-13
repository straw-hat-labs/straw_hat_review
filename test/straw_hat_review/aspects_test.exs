defmodule StrawHat.Review.AspectsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.{Aspects, Aspect}

  describe "find_aspect/1" do
    test "with valid id" do
      aspect = insert(:aspect)

      assert {:ok, _aspect} = Aspects.find_aspect(aspect.id)
    end

    test "with invalid id shouldn't find the aspect" do
      assert {:error, _reason} = Ecto.UUID.generate() |> Aspects.find_aspect()
    end
  end

  test "get_aspects/1 list the aspects per page" do
    insert_list(10, :aspect)
    aspect = Aspects.get_aspects(%{page: 2, page_size: 5})

    assert length(aspect.entries) == 5
  end

  test "create_aspect/1 with valid inputs creates an aspect" do
    params = params_for(:aspect)

    assert {:ok, _aspect} = Aspects.create_aspect(params)
  end

  test "update_aspect/2 with valid inputs updates an aspect" do
    aspect = insert(:aspect)
    {:ok, aspect} = Aspects.update_aspect(aspect, %{name: "Professional"})

    assert aspect.name == "professional"
  end

  test "destroy_aspect/1 with a found review destroys the aspect" do
    aspect = insert(:aspect)

    assert {:ok, _} = Aspects.destroy_aspect(aspect)
  end

  test "change_aspect/1 returns an aspect changeset" do
    assert %Ecto.Changeset{} = Aspects.change_aspect(%Aspect{})
  end
end
