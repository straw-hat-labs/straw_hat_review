defmodule StrawHat.Review.Schema.Helpful do
  @moduledoc """
  Represents a Helpful Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Schema.Review

  @typedoc """
  - ***classification:*** The `classification` field can use for mark the comment is useful or
  not. The value can be (YES, NO, RECOMMENDED, LOW_INTUITIVE).
  - ***reviews_id:*** The review used for the helpful comment.
  - ***user_id:*** The `user` that make the helpful comment.
  - ***comment:*** The text write in the helpful comment.
  """
  @type t :: %__MODULE__{
          classification: String.t(),
          review_id: Integer.t(),
          user_id: String.t(),
          comment: String.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type helpful_attrs :: %{
          classification: String.t(),
          review_id: Integer.t(),
          user_id: String.t(),
          comment: String.t()
        }

  @required_fields ~w(classification review_id user_id comment)a

  schema "helpful" do
    field(:classification, :string)
    belongs_to(:review, Review)
    field(:user_id, :string)
    field(:comment, :string)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Helpful.
  """
  @spec changeset(t, helpful_attrs) :: Ecto.Changeset.t()
  def changeset(helpful, helpful_attrs) do
    helpful
    |> cast(helpful_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:review)
  end
end
