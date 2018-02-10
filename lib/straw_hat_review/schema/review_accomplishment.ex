defmodule StrawHat.Review.Schema.ReviewAccomplishment do
  @moduledoc """
  Represents a Review Accomplishment Ecto Schema relation.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Schema.{Review, Accomplishment}

  @typedoc """
  - ***review_id:*** The `review_id` is a reference to Review schema.
  - ***accomplishment_id:*** The `accomplistment_id` is a reference to Accomplishment schema.
  """
  @type t :: %__MODULE__{
          review_id: Integer.t(),
          accomplishment_id: Integer.t()
        }

  @typedoc """
  Check `t` type for more information about the keys.
  """
  @type review_accomplishment_attrs :: %{
          review_id: Integer.t(),
          partial_id: Integer.t()
        }

  @required_fields ~w(template_id partial_id)a

  @primary_key false
  schema "review_accomplishments" do
    belongs_to(:review, Review)
    belongs_to(:accomplishment, Accomplishment)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Review Accomplishment.
  """
  @spec changeset(t, review_accomplishment_attrs) :: Ecto.Changeset.t()
  def changeset(review_accomplishment, review_accomplishment_attrs) do
    review_accomplishment
    |> cast(review_accomplishment_attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
