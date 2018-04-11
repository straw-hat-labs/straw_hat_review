defmodule StrawHat.Review.Test.ReviewsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Reviews

  describe "find_review/1" do
    test "with valid id" do
      review = insert(:review)

      assert {:ok, _review} = Reviews.find_review(review.id)
    end

    test "with invalid id shouldn't find the review" do
      assert {:error, _reason} = Reviews.find_review(8347)
    end
  end

  test "get_reviews/1 list the reviews per page" do
    insert_list(10, :review)
    review = Reviews.get_reviews(%{page: 2, page_size: 5})

    assert length(review.entries) == 5
  end

  describe "create_review/1" do

    test "with valid inputs creates a review" do
      params = params_for(:review)

      assert {:ok, _review} = Reviews.create_review(params)
    end

    test "with valid inputs creates a review with aspect" do
      aspect = insert(:aspect)

      params =
        :review
        |> params_for()
        |> Map.put(:aspects, [%{score: 3, aspect_id: aspect.id}])

      assert {:ok, review} = Reviews.create_review(params)
      assert length(review.reviews_aspects) == 1
    end

    test "with valid inputs creates a review with media" do

      media_params = %{
        content_type: "image/png",
        file_name: "elixir_logo.png",
        file: %Plug.Upload{
          content_type: "image/png",
          filename: "elixir_logo.png",
          path: "test/features/files/elixir_logo.png"
        }
      }

      params =
        :review
        |> params_for()
        |> Map.put(:medias, [media_params])

      assert {:ok, review} = Reviews.create_review(params)
      assert length(review.medias) == 1
    end
  end

  test "update_review/2 with valid inputs updates a review" do
    review = insert(:review)
    {:ok, review} = Reviews.update_review(review, %{comment: "Awesome!!!"})

    assert review.comment == "Awesome!!!"
  end

  test "review_by_ids/1 with valid ids list return the respective reviews" do
    review = insert(:review)
    reviews = Reviews.review_by_ids([review.id])

    assert length(reviews) == 1
  end

  test "get_medias/1 with valid ids list return the associated medias" do
    media_params = %{
      content_type: "image/png",
      file_name: "elixir_logo.png",
      file: %Plug.Upload{
        content_type: "image/png",
        filename: "elixir_logo.png",
        path: "test/features/files/elixir_logo.png"
      }
    }

    params =
      :review
      |> params_for()
      |> Map.put(:medias, [media_params])

    assert {:ok, review} = Reviews.create_review(params)
 
    reviews = Reviews.get_medias([review.id])
    assert length(Enum.at(reviews, 0).medias) == 1
  end

  test "get_reviews_aspects/1 with valid ids list return the respective reviews aspects" do
    aspect = insert(:aspect)

    params =
      :review
      |> params_for()
      |> Map.put(:aspects, [%{score: 3, aspect_id: aspect.id}])

    assert {:ok, review} = Reviews.create_review(params)

    reviews = Reviews.get_reviews_aspects([review.id])

    assert length(Enum.at(reviews, 0).reviews_aspects) == 1
  end

  test "get_comments/1 with valid ids list return the respective reviews comments" do
    review = insert(:review)
    comment = insert(:comment, review: review)
    reviews = Reviews.get_comments([review.id])

    assert length(Enum.at(reviews, 0).comments) == 1
  end

  test "get_reviews_reactions/1 with valid ids list return the respective reviews reactions" do
    review = insert(:review)
    reaction = insert(:reaction)
    reviews_reactions = insert(:reviews_reactions, reaction: reaction, review: review)
    reviews = Reviews.get_reviews_reactions([review.id])

    assert length(Enum.at(reviews, 0).reviews_reactions) == 1
  end

  test "destroy_review/1 with a found review destroys the review" do
    review = insert(:review)

    assert {:ok, _} = Reviews.destroy_review(review)
  end
end
