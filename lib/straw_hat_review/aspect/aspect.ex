defmodule StrawHat.Review.Aspect do
  @moduledoc """
  Represents a Aspect Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.ReviewAspect

  @typedoc """
  - `name`: The aspect identificator above another aspects.
  - `review_aspects`: List of `t:StrawHat.Review.ReviewAspect.t/0` associated with the current aspect.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          review_aspects: [ReviewAspect.t()] | Ecto.Association.NotLoaded.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type aspect_attrs :: %{
          name: String.t()
        }

  @required_fields ~w(name)a

  schema "aspects" do
    field(:name, :string)

    timestamps()
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Aspect.
  """
  @since "1.0.0"
  @spec changeset(t, aspect_attrs) :: Ecto.Changeset.t()
  def changeset(aspect, aspect_attrs) do
    aspect
    |> cast(aspect_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :aspects_name_index)
  end
end
