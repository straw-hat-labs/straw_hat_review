defmodule StrawHat.Review.Test.TagTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Tag

  test "get tag by id" do
    tag = insert(:tag)
    assert Tag.get_tag(tag.id) != nil
  end

  test "get tag with invalid id" do
    assert {:error, _reason} = Tag.find_tag(836747)
  end

  test "list per page" do
    insert_list(10, :tag)
    tag = Tag.get_tags(%{page: 2, page_size: 5})
    assert tag.total_entries == 10
  end

  test "create tag" do
    params = params_for(:tag)
    assert {:ok, _tag} = Tag.create_tag(params)
  end

  test "update tag" do
    tag = insert(:tag)
    {:ok, tag} = Tag.update_tag(tag, %{name: "Friendly"})
    assert tag.name == "Friendly"
  end

  test "delete tag" do
    tag = insert(:tag)
    assert {:ok, _} = Tag.destroy_tag(tag)
  end
end
