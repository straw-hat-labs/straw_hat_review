defmodule StrawHat.Review.Test.OwnerTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Owner

  test "add achievement badge to owner" do
    achievement_badge = insert(:achievement_badge)
    params = params_for(:achievement, %{achievement_badge_id: achievement_badge.id})
    assert {:ok, _achievement} = Owner.add_achievement_badge(params)
  end

  test "remove achievement badge from owner" do
    %{owner_id: owner, achievement_badge_id: achievement_badge} = insert(:achievement)
    assert {count, _} = Owner.remove_achievement_badges(owner, [achievement_badge])
    assert count == 1
  end
end
