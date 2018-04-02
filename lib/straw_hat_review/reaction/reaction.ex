defmodule StrawHat.Review.Reaction do
  @moduledoc """
  Represents a Reaction Ecto Schema.
  """

  use StrawHat.Review.Schema

  @typedoc """
  - `name`: The reaction identificator above another reactions.
  """
  @type t :: %__MODULE__{
          name: String.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type reaction_attrs :: %{
          name: String.t()
        }

  @required_fields ~w(name)a

  schema "reactions" do
    field(:name, :string)

    timestamps()
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Reaction.
  """
  @since "1.0.0"
  @spec changeset(t, reaction_attrs) :: Ecto.Changeset.t()
  def changeset(reaction, reaction_attrs) do
    reaction
    |> cast(reaction_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :reactions_name_index)
  end
end
