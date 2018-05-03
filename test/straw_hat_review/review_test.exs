defmodule StrawHat.Review.ReviewsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.{Reviews, Review}

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
      params = review_attrs()
      assert {:ok, _review} = Reviews.create_review(params)
    end

#    test "with valid inputs creates a review with aspect" do
#      params = review_attrs()
#
#      assert {:ok, review} = Reviews.create_review(params)
#      assert length(review.reviews_aspects) == 1
#    end

#    test "with valid inputs creates a review with media" do
#      params =
#        :review
#        |> review_attrs()
#        |> Map.put(:medias, build_list(2, :file))
#
#      assert {:ok, review} = Reviews.create_review(params)
#      assert length(review.medias) == 1
#    end
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

#  test "get_medias/1 with valid ids list return the associated medias" do
#    media_params = %{
#      content_type: "image/png",
#      file_name: "elixir_logo.png",
#      file: %Plug.Upload{
#        content_type: "image/png",
#        filename: "elixir_logo.png",
#        path: "test/features/files/elixir_logo.png"
#      }
#    }
#
#    params = review_attrs()
#    assert {:ok, review} = Reviews.create_review(params)
#
#    reviews = Reviews.get_medias([review.id])
#    assert length(Enum.at(reviews, 0).medias) == 1
#  end

  test "get_reviews_aspects/1 with valid ids list return the respective reviews aspects" do
    aspect = insert(:aspect)

    params =
      :review
      |> params_for()
      |> Map.put(:aspects, [%{score: 3, aspect_id: aspect.id}])

    assert {:ok, review} = Reviews.create_review(params)

    reviews = Reviews.get_reviews_aspects([review.id])

    assert length(Enum.at(reviews, 0).aspects) == 1
  end

  test "get_comments/1 with valid ids list return the respective reviews comments" do
    review = insert(:review)
    insert(:comment, review: review)
    reviews = Reviews.get_comments([review.id])

    assert length(Enum.at(reviews, 0).comments) == 1
  end

  test "get_reviews_reactions/1 with valid ids list return the respective reviews reactions" do
    reviews_reactions = insert(:reviews_reactions)
    reviews = Reviews.get_reviews_reactions([
      reviews_reactions.review_id
    ])

    assert length(Enum.at(reviews, 0).reactions) == 1
  end

  test "destroy_review/1 with a found review destroys the review" do
    review = insert(:review)

    assert {:ok, _} = Reviews.destroy_review(review)
  end

  test "add_reaction/3 without exist review reaction" do
    user_id = "user:2365"
    review = insert(:review)
    reaction = insert(:reaction)

    assert {:ok, review_reaction} = Reviews.add_reaction(review.id, user_id, reaction.id)
    assert review_reaction.reaction_id == reaction.id
  end

  test "add_reaction/3 with exist review reaction" do
    review = insert(:review)
    reaction = insert(:reaction)
    review_reaction = insert(:reviews_reactions, review: review, reaction: reaction)
    new_reaction = insert(:reaction)

    assert {:ok, update_review_reaction} =
             Reviews.add_reaction(review.id, review_reaction.user_id, new_reaction.id)

    assert update_review_reaction.id == review_reaction.id
    assert update_review_reaction.reaction_id == new_reaction.id
  end

  test "change_review/1 returns a review changeset" do
    assert %Ecto.Changeset{} = Reviews.change_review(%Review{})
  end
end
