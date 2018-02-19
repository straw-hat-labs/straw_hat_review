defmodule StrawHat.Review.Test.AchievementBadgeTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.AchievementBadge

  test "get achievement badge by id" do
    achievement_badge = insert(:achievement_badge)
    assert AchievementBadge.get_achievement_badge(achievement_badge.id) != nil
  end

  test "get achievement badge with invalid id" do
    assert {:error, _reason} = AchievementBadge.find_achievement_badge(836_747)
  end

  test "list per page" do
    insert_list(10, :achievement_badge)
    achievement_badge = AchievementBadge.get_achievement_badges(%{page: 2, page_size: 5})
    assert achievement_badge.total_entries == 10
  end

  test "create achievement badge" do
    params = params_for(:achievement_badge)
    assert {:ok, _achievement_badge} = AchievementBadge.create_achievement_badge(params)
  end

  test "update achievement badge" do
    achievement_badge = insert(:achievement_badge)

    {:ok, achievement_badge} =
      AchievementBadge.update_achievement_badge(achievement_badge, %{name: "Five client in three hours"})

    assert achievement_badge.name == "Five client in three hours"
  end

  test "delete achievement badge" do
    achievement_badge = insert(:achievement_badge)
    assert {:ok, _} = AchievementBadge.destroy_achievement_badge(achievement_badge)
  end
end
