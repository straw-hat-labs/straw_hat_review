defmodule StrawHat.Review.Test.Factory do
  use ExMachina.Ecto, repo: StrawHat.Review.Repo

  alias StrawHat.Review.Schema.{Tag, Accomplishment, Helpful, Review}

  def tag_factory do
    %Tag{
      name: Faker.String.base64()
    }
  end

  def accomplishment_factory do
    %Accomplishment{
      name: Faker.String.base64()
    }
  end

  def helpful_factory do
    %Helpful{
      classification: Faker.Pokemon.name(),
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

  defp get_score() do
    Enum.take_random(1..5, 1) |> List.first()
  end
end
