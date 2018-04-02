defmodule StrawHat.Review.Test.Factory do
  use ExMachina.Ecto, repo: StrawHat.Review.Repo

  alias StrawHat.Review.{Review, Aspect, Comment, Reaction, CommentReaction, Attachment, ReviewReaction, ReviewAspect}

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

  def attachment_factory do
    %Attachment{
      content_type: Faker.File.mime_type(:image),
      file_name: Faker.String.base64(),
      file: Faker.String.base64(),
      review: build(:review)
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

  def reviews_aspects do
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
    Enum.take_random(1..5, 1) |> List.first()
  end
end
