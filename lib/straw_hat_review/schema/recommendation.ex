defmodule StrawHat.Review.Schema.Recommendation do
  @moduledoc """
  Represents a Recommendation Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Schema.Review

  @typedoc """
  - ***type:*** The `type` field can use for mark the comment is useful or
  not. The value can be (YES, NO, RECOMMENDED, LOW_INTUITIVE).
  - ***reviews_id:*** The review used for the recommendation comment.
  - ***user_id:*** The `user` that make the recommendation comment.
  - ***comment:*** The text write in the recommendation comment.
  """
  @type t :: %__MODULE__{
          type: String.t(),
          review_id: Integer.t(),
          user_id: String.t(),
          comment: String.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type recommendation_attrs :: %{
          type: String.t(),
          review_id: Integer.t(),
          user_id: String.t(),
          comment: String.t()
        }

  @required_fields ~w(type review_id user_id comment)a

  schema "recommendations" do
    field(:type, :string)
    belongs_to(:review, Review)
    field(:user_id, :string)
    field(:comment, :string)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Recommendation.
  """
  @spec changeset(t, recommendation_attrs) :: Ecto.Changeset.t()
  def changeset(recommendation, recommendation_attrs) do
    recommendation
    |> cast(recommendation_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:review)
  end
end
