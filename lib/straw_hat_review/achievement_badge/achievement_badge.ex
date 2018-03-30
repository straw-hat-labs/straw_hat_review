defmodule StrawHat.Review.AchievementBadge do
  @moduledoc """
  Represents a AchievementBadge Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Achievement

  @typedoc """
  - `name`: The achievement badge name identificator.
  - `achievements`: List of `t:StrawHat.Review.Achievement.t/0` associated
  with the current achievement badge.
  - `inserted_at`: When the record was inserted.
  - `updated_at`: When was the last time the record was updated.
  """
  @type t :: %__MODULE__{
          name: String.t(),
          achievements: [Achievement.t()] | Ecto.Association.NotLoaded.t()
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
    timestamps()

    has_many(
      :achievements,
      Achievement,
      on_replace: :delete,
      on_delete: :delete_all
    )
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current AchievementBadge.
  """
  @since "1.0.0"
  @spec changeset(t, achievement_badge_attrs) :: Ecto.Changeset.t()
  def changeset(achievement_badge, achievement_badge_attrs) do
    achievement_badge
    |> cast(achievement_badge_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
