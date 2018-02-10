defmodule StrawHat.Review.Schema.Accomplishment do
  @moduledoc """
  Represents a Accomplishment Ecto Schema.
  """

  use StrawHat.Review.Schema

  @typedoc """
  - ***name:*** The accomplishment identificator above another accomplishments.
  """
  @type t :: %__MODULE__{
          name: String.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type accomplishment_attrs :: %{
          name: String.t()
        }

  @required_fields ~w(name)a

  schema "accomplishments" do
    field(:name, :string)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Accomplishment.
  """
  @spec changeset(t, accomplishment_attrs) :: Ecto.Changeset.t()
  def changeset(accomplishment, accomplishment_attrs) do
    accomplishment
    |> cast(accomplishment_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :accomplishments_name_index)
  end
end
