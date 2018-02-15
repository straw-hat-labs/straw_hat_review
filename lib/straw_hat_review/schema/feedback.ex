defmodule StrawHat.Review.Schema.Feedback do
  @moduledoc """
  Represents a Feedback Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Schema.Review

  @typedoc """
  - ***type:*** The `type` field can use for mark the comment is useful or
  not. The value can be (YES, NO, RECOMMENDED, LOW_INTUITIVE).
  - ***reviews_id:*** The review used for the feedback comment.
  - ***user_id:*** The `user` that make the feedback comment.
  - ***comment:*** The text write in the feedback comment.
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
  @type feedback_attrs :: %{
          type: String.t(),
          review_id: Integer.t(),
          user_id: String.t(),
          comment: String.t()
        }

  @required_fields ~w(type review_id user_id comment)a

  schema "feedbacks" do
    field(:type, :string)
    belongs_to(:review, Review)
    field(:user_id, :string)
    field(:comment, :string)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Feedback.
  """
  @spec changeset(t, feedback_attrs) :: Ecto.Changeset.t()
  def changeset(feedback, feedback_attrs) do
    feedback
    |> cast(feedback_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:review)
  end
end
