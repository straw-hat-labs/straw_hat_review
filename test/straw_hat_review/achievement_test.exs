defmodule StrawHat.Review.Test.AchievementTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Achievement

  test "get achievement by id" do
    achievement = insert(:achievement)
    assert Achievement.get_achievement(achievement.id) != nil
  end

  test "get achievement with invalid id" do
    assert {:error, _reason} = Achievement.find_achievement(836_747)
  end

  test "list per page" do
    insert_list(10, :achievement)
    achievement = Achievement.get_achievements(%{page: 2, page_size: 5})
    assert achievement.total_entries == 10
  end

  test "create achievement" do
    achievement_badge = insert(:achievement_badge)
    params = params_for(:achievement, achievement_badge_id: achievement_badge.id)
    assert {:ok, _achievement} = Achievement.create_achievement(params)
  end

  test "update achievement" do
    achievement = insert(:achievement)
    {:ok, achievement} = Achievement.update_achievement(achievement, %{owner_id: "user:4589"})
    assert achievement.owner_id == "user:4589"
  end

  test "delete achievement" do
    achievement = insert(:achievement)
    assert {:ok, _} = Achievement.destroy_achievement(achievement)
  end
end
