defmodule StrawHat.Review.TagsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Tags

  describe "find_tag/1" do
    test "with valid id" do
      tag = insert(:tag)

      assert {:ok, _tag} = Tags.find_tag(tag.id)
    end

    test "with invalid id shouldn't find the tag" do
      assert {:error, _reason} = Tags.find_tag(8347)
    end
  end

  test "get_tags/1 list the tags per page" do
    insert_list(5, :tag)
    tags = Tags.get_tags(%{page: 2, page_size: 2})

    assert length(tags.entries) == 2
  end

  test "create_tag/1 with valid inputs creates a tag" do
    params = params_for(:tag)

    assert {:ok, _tag} = Tags.create_tag(params)
  end

  test "update_tag/2 with valid inputs updates a tag" do
    tag = insert(:tag)
    {:ok, tag} = Tags.update_tag(tag, %{name: "Professional"})

    assert tag.name == "Professional"
  end

  test "destroy_tag/1 with a found review destroys the tag" do
    tag = insert(:tag)

    assert {:ok, _} = Tags.destroy_tag(tag)
  end
end
