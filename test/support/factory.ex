defmodule StrawHat.Review.Test.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: StrawHat.Review.Repo

  alias StrawHat.Review.{
    Review,
    Aspect,
    Comment,
    Reaction,
    CommentReaction,
    Media,
    ReviewReaction,
    ReviewAspect
  }

  def aspect_factory do
    %Aspect{
      name: Faker.String.base64()
    }
  end

  def reaction_factory do
    %Reaction{
      name: Faker.String.base64()
    }
  end

  def comment_factory do
    %Comment{
      comment: Faker.Lorem.Shakespeare.hamlet(),
      owner_id: Faker.String.base64(),
      review: build(:review)
    }
  end

  def media_factory do
    %Media{
      content_type: "image/png",
      file_name: "elixir_logo.png",
      review: build(:review),
      file: get_file()
    }
  end

  def comments_reactions_factory do
    %CommentReaction{
      comment: build(:comment),
      reaction: build(:reaction),
      user_id: Faker.String.base64()
    }
  end

  def reviews_reactions_factory do
    %ReviewReaction{
      review: build(:review),
      reaction: build(:reaction),
      user_id: Faker.String.base64()
    }
  end

  def reviews_aspects_factory do
    %ReviewAspect{
      review: build(:review),
      aspect: build(:aspect),
      score: get_score()
    }
  end

  def review_factory do
    %Review{
      reviewee_id: Faker.String.base64(),
      reviewer_id: Faker.String.base64(),
      comment: Faker.Lorem.Shakespeare.hamlet()
    }
  end

  defp get_score() do
    1..5
    |> Enum.take_random(1)
    |> List.first()
  end

  defp get_file() do
    %Plug.Upload{
      content_type: "image/png",
      filename: "elixir_logo.png",
      path: "test/features/files/elixir_logo.png"
    }
  end
end
