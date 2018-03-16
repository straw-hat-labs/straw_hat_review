defmodule StrawHat.Review.Owner do
  @moduledoc """
  Virtual interactor module that defines all the functionality for Owner management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.Achievement
  alias StrawHat.Review.Query.AchievementQuery


  @doc """
  Add achievement badge to owner.
  """
  @spec add_achievement_badge(Achievement.achievement_attrs()) :: {:ok, Achievement.t()} | {:error, Ecto.Changeset.t()}
  def add_achievement_badge(achievement_attrs) do
    %Achievement{}
    |> Achievement.changeset(achievement_attrs)
    |> Repo.insert()
  end

  @doc """
  Remove achievement badge from owner.
  """
  @spec remove_achievement_badges(Integer.t(), [Integer.t()]) :: {integer, nil | [term]} | no_return
  def remove_achievement_badges(owner_id, achievement_badges) do
    Achievement
    |> AchievementQuery.get_by(owner_id, achievement_badges)
    |> Repo.delete_all()
  end
end
