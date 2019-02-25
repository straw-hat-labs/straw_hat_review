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

  @name_regex ~r/^[a-z]+[a-z_]+[a-z]$/

  schema "reactions" do
    field(:name, :string)

    timestamps()
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Reaction.
  """
  @spec changeset(t, reaction_attrs) :: Ecto.Changeset.t()
  def changeset(reaction, reaction_attrs) do
    reaction
    |> cast(reaction_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_name()
  end

  @spec validate_name(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp validate_name(changeset) do
    changeset
    |> update_change(:name, &cleanup_name/1)
    |> validate_format(:name, @name_regex)
    |> unique_constraint(:name)
  end

  @spec cleanup_name(String.t()) :: String.t()
  defp cleanup_name(name) do
    name
    |> String.trim()
    |> String.replace(~r/\s/, "_")
    |> String.downcase()
  end
end
