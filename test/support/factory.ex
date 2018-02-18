defmodule StrawHat.Review.Test.Factory do
  use ExMachina.Ecto, repo: StrawHat.Review.Repo

  alias StrawHat.Review.Schema.{Tag, Aspect, Feedback, Review, ReviewAspect}

  def tag_factory do
    %Tag{
      name: Faker.String.base64()
    }
  end

  def aspect_factory do
    %Aspect{
      name: Faker.String.base64()
    }
  end

  def feedback_factory do
    %Feedback{
      type: Faker.Pokemon.name(),
      review: build(:review),
      user_id: Faker.String.base64(),
      comment: Faker.Lorem.Shakespeare.hamlet()
    }
  end

  def review_factory do
    %Review{
      date: DateTime.utc_now(),
      score: get_score(),
      reviewee_id: Faker.String.base64(),
      reviewer_id: Faker.String.base64(),
      comment: Faker.Lorem.Shakespeare.hamlet()
    }
  end

  def review_aspect do
    %ReviewAspect{
      aspect_id: build(:aspect),
      review_id: build(:review),
      comment: Faker.Lorem.Shakespeare.hamlet(),
      score: get_score()
    }
  end

  defp get_score() do
    Enum.take_random(1..5, 1) |> List.first()
  end
end
