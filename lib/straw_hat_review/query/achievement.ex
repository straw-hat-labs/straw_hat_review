defmodule StrawHat.Review.Query.AchievementQuery do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  @spec get_by(Achievement.t(), String.t(), [Integer.t()]) :: Ecto.Query.t()
  def get_by(query, owner_id, achievement_badge_ids) do
    from(
      achievement in query,
      where: achievement.owner_id == ^owner_id,
      where: achievement.achievement_badge_id in ^achievement_badge_ids
    )
  end
end
