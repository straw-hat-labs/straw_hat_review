defmodule StrawHat.Review.Test.AchievementBadgesTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.AchievementBadges

  describe "find_achievement_badge/1" do
    test "with valid id return the relative achievement badge" do
      achievement_badge = insert(:achievement_badge)

      assert {:ok, _achievement_badge} = AchievementBadges.find_achievement_badge(achievement_badge.id)
    end

    test "with invalid id shouldn't find the achievement badge" do
      assert {:error, _reason} = AchievementBadges.find_achievement_badge(8347)
    end
  end

  test "get_achievement_badges/1 list the achievement badges per page" do
    insert_list(10, :achievement_badge)
    achievement_badge = AchievementBadges.get_achievement_badges(%{page: 2, page_size: 5})

    assert length(achievement_badge.entries) == 5
  end

  test "create_achievement_badge/1 with valid inputs creates a achievement badge" do
    params = params_for(:achievement_badge)

    assert {:ok, _achievement_badge} = AchievementBadges.create_achievement_badge(params)
  end

  test "update_achievement_badge/2 with valid inputs updates a achievement badge" do
    achievement_badge = insert(:achievement_badge)

    {:ok, achievement_badge} =
      AchievementBadges.update_achievement_badge(achievement_badge, %{name: "Five client in three hours"})

    assert achievement_badge.name == "Five client in three hours"
  end

  test "destroy_achievement_badge/1 with a found review destroys the achievement badge" do
    achievement_badge = insert(:achievement_badge)

    assert {:ok, _} = AchievementBadges.destroy_achievement_badge(achievement_badge)
  end
end
