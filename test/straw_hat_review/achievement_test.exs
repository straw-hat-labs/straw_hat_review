defmodule StrawHat.Review.AchievementsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Achievements

  describe "find_achievement/1" do
    test "with valid id" do
      achievement = insert(:achievement)

      assert {:ok, _achievement} = Achievements.find_achievement(achievement.id)
    end

    test "with invalid id shouldn't find the achievement" do
      assert {:error, _reason} = Achievements.find_achievement(8347)
    end
  end

  test "get_achievements/1 list the achievements per page" do
    insert_list(5, :achievement)
    achievement = Achievements.get_achievements(%{page: 2, page_size: 2})

    assert length(achievement.entries) == 2
  end

  test "create_achievement/1 with valid inputs creates a achievement" do
    achievement = insert(:achievement)

    params = %{
      owner_id: achievement.owner_id,
      achievement_badge_id: achievement.achievement_badge.id
    }

    assert {:error, _error} = Achievements.create_achievement(params)
  end

  test "create_achievement/1 shouldn't duplicate the achievement" do
    achievement_badge = insert(:achievement_badge)
    params = params_for(:achievement, achievement_badge_id: achievement_badge.id)

    assert {:ok, _achievement} = Achievements.create_achievement(params)
    assert {:error, _achievement} = Achievements.create_achievement(params)
  end

  test "update_achievement/2 with valid inputs updates a achievement" do
    achievement = insert(:achievement)
    {:ok, achievement} = Achievements.update_achievement(achievement, %{owner_id: "user:4589"})

    assert achievement.owner_id == "user:4589"
  end

  test "destroy_achievement/1 with a found review destroys the achievement" do
    achievement = insert(:achievement)
    assert {:ok, _} = Achievements.destroy_achievement(achievement)
  end
end
