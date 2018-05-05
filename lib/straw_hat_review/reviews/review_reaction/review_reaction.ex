defmodule StrawHat.Review.ReviewReaction do
  @moduledoc """
  Represents a ReviewReaction Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.{Review, Reaction}

  @typedoc """
  - `review`: `t:StrawHat.Review.Review.t/0` associated with the current review reaction.
  - `review_id`: The review used for the review reaction.
  - `reaction`: `t:StrawHat.Review.Reaction.t/0` associated with the current review reaction.
  - `reaction_id`: The reaction used for the review reaction.
  - `user_id`: The user that react to review.
  """
  @type t :: %__MODULE__{
          review: Review.t() | Ecto.Association.NotLoaded.t(),
          review_id: Integer.t(),
          reaction: Reaction.t() | Ecto.Association.NotLoaded.t(),
          reaction_id: Integer.t(),
          user_id: String.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type review_reaction_attrs :: %{
          review_id: Integer.t(),
          reaction_id: Integer.t(),
          user_id: String.t()
        }

  @required_fields ~w(review_id reaction_id user_id)a

  schema "reviews_reactions" do
    field(:user_id, :string)
    belongs_to(:review, Review)
    belongs_to(:reaction, Reaction)

    timestamps()
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current ReviewReaction.
  """
  @since "1.0.0"
  @spec changeset(t, review_reaction_attrs) :: Ecto.Changeset.t()
  def changeset(review_reaction, review_reaction_attrs) do
    review_reaction
    |> cast(review_reaction_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:review)
    |> assoc_constraint(:reaction)
  end
end
