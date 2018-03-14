defmodule StrawHat.Review.Schema.AchievementBadge do
  @moduledoc """
  Represents a AchievementBadge Ecto Schema.
  """

  use StrawHat.Review.Schema

  @typedoc """
  - `name`: The achievement_badge identificator above another achievement_badges.
  """
  @type t :: %__MODULE__{
          name: String.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type achievement_badge_attrs :: %{
          name: String.t()
        }

  @required_fields ~w(name)a

  schema "achievement_badges" do
    field(:name, :string)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current AchievementBadge.
  """
  @spec changeset(t, achievement_badge_attrs) :: Ecto.Changeset.t()
  def changeset(achievement_badge, achievement_badge_attrs) do
    achievement_badge
    |> cast(achievement_badge_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :achievement_badges_name_index)
  end
end
