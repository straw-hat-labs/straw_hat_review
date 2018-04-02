defmodule StrawHat.Review.Aspect do
  @moduledoc """
  Represents a Aspect Ecto Schema.
  """

  use StrawHat.Review.Schema

  @typedoc """
  - `name`: The aspect identificator above another aspects.
  """
  @type t :: %__MODULE__{
          name: String.t()
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
  Validates the attributes and return a Ecto.Changeset for the current Aspect.
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
