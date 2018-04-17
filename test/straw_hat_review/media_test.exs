defmodule StrawHat.Review.MediasTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Medias

  describe "find_media/1" do
    test "with valid id" do
      media = insert(:media)

      assert {:ok, _media} = Medias.find_media(media.id)
    end

    test "with invalid id shouldn't find the media" do
      assert {:error, _reason} = Medias.find_media(8347)
    end
  end

  test "get_medias/1 list the medias per page" do
    insert_list(10, :media)
    media = Medias.get_medias(%{page: 2, page_size: 5})

    assert length(media.entries) == 5
  end

  test "create_media/1 with valid inputs creates a media" do
    review = insert(:review)
    params = params_for(:media, review: review)

    assert {:ok, _media} = Medias.create_media(params)
  end

  test "update_media/2 with valid inputs updates a media" do
    media = insert(:media)
    {:ok, media} = Medias.update_media(media, %{content_type: "text/html"})

    assert media.content_type == "text/html"
  end

  test "destroy_media/1 with a found review destroys the media" do
    media = insert(:media)

    assert {:ok, _} = Medias.destroy_media(media)
  end
end
