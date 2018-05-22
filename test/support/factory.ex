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
      name: Faker.format("???_???")
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
      file: build(:file)
    }
  end

  def comments_reactions_factory do
    %CommentReaction{
      comment: build(:comment),
      reaction: build(:reaction),
      user_id: Faker.String.base64()
    }
  end

  def review_reaction_factory do
    %ReviewReaction{
      review: build(:review),
      reaction: build(:reaction),
      user_id: Faker.String.base64()
    }
  end

  def review_aspect_factory do
    %ReviewAspect{
      aspect: build(:aspect),
      score: get_score()
    }
  end

  def review_factory do
    %Review{
      reviewee_id: Faker.String.base64(),
      reviewer_id: Faker.String.base64(),
      comment: Faker.Lorem.Shakespeare.hamlet(),
      aspects: build_list(2, :review_aspect)
    }
  end

  # credo:disable-for-next-line
  # TODO: remove this functions
  # related to: https://github.com/thoughtbot/ex_machina/issues/279
  def review_attrs do
    :review
    |> params_for()
    |> Map.put(:aspects, [params_with_assocs(:review_aspect)])
    |> Map.put(:medias, build_list(2, :file))
  end

  defp get_score() do
    1..5
    |> Enum.take_random(1)
    |> List.first()
  end

  def file_factory() do
    %Plug.Upload{
      content_type: "image/png",
      filename: "elixir_logo.png",
      path: "test/features/files/elixir_logo.png"
    }
  end
end
