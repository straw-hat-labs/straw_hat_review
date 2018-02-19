defmodule StrawHat.Review.Test.Factory do
  use ExMachina.Ecto, repo: StrawHat.Review.Repo

  alias StrawHat.Review.Schema.{Tag, Aspect, AchievementBadge, Achievement, Feedback, Review, ReviewAspect}

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

  def achievement_badge_factory do
    %AchievementBadge{
      name: Faker.String.base64()
    }
  end

  def achievement_factory do
    %Achievement{
      owner_id: Faker.String.base64(),
      achievement_badge: build(:achievement_badge),
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

  def review_aspect_factory do
    %ReviewAspect{
      aspect: build(:aspect),
      review: build(:review),
      comment: Faker.Lorem.Shakespeare.hamlet(),
      score: get_score()
    }
  end

  defp get_score() do
    Enum.take_random(1..5, 1) |> List.first()
  end
end
