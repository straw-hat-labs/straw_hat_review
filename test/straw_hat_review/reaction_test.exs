defmodule StrawHat.Review.Test.ReactionsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Reactions

  describe "find_reaction/1" do
    test "with valid id" do
      reaction = insert(:reaction)

      assert {:ok, _reaction} = Reactions.find_reaction(reaction.id)
    end

    test "with invalid id shouldn't find the reaction" do
      assert {:error, _reason} = Reactions.find_reaction(8347)
    end
  end

  test "get_reactions/1 list the reactions per page" do
    insert_list(10, :reaction)
    reaction = Reactions.get_reactions(%{page: 2, page_size: 5})

    assert length(reaction.entries) == 5
  end

  test "create_reaction/1 with valid inputs creates a reaction" do
    params = params_for(:reaction, name: "Professional")

    assert {:ok, _reaction} = Reactions.create_reaction(params)
  end

  test "update_reaction/2 with valid inputs updates a reaction" do
    reaction = insert(:reaction)
    {:ok, reaction} = Reactions.update_reaction(reaction, %{name: "Professional"})

    assert reaction.name == "professional"
  end

  test "destroy_reaction/1 with a found review destroys the reaction" do
    reaction = insert(:reaction)

    assert {:ok, _} = Reactions.destroy_reaction(reaction)
  end
end
