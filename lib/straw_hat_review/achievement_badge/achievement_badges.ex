defmodule StrawHat.Review.AchievementBadges do
  @moduledoc """
  Interactor module that defines all the functionality for AchievementBadges management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.AchievementBadge

  @doc """
  Get the list of achievement badges.
  """
  @since "1.0.0"
  @spec get_achievement_badges(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_achievement_badges(pagination \\ []), do: Repo.paginate(AchievementBadge, pagination)

  @doc """
  Create a achievement badge.
  """
  @since "1.0.0"
  @spec create_achievement_badge(AchievementBadge.achievement_badge_attrs()) :: {:ok, AchievementBadge.t()} | {:error, Ecto.Changeset.t()}
  def create_achievement_badge(achievement_badge_attrs) do
    %AchievementBadge{}
    |> AchievementBadge.changeset(achievement_badge_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a achievement badge.
  """
  @since "1.0.0"
  @spec update_achievement_badge(AchievementBadge.t(), AchievementBadge.achievement_badge_attrs()) ::
          {:ok, AchievementBadge.t()} | {:error, Ecto.Changeset.t()}
  def update_achievement_badge(%AchievementBadge{} = achievement_badge, achievement_badge_attrs) do
    achievement_badge
    |> AchievementBadge.changeset(achievement_badge_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a achievement badge.
  """
  @since "1.0.0"
  @spec destroy_achievement_badge(AchievementBadge.t()) :: {:ok, AchievementBadge.t()} | {:error, Ecto.Changeset.t()}
  def destroy_achievement_badge(%AchievementBadge{} = achievement_badge), do: Repo.delete(achievement_badge)

  @doc """
  Find a achievement badge by `id`.
  """
  @since "1.0.0"
  @spec find_achievement_badge(Integer.t()) :: {:ok, AchievementBadge.t()} | {:error, Error.t()}
  def find_achievement_badge(achievement_badge_id) do
    case get_achievement_badge(achievement_badge_id) do
      nil ->
        error = Error.new("straw_hat_achievement_badge.achievement_badge.not_found", metadata: [achievement_badge_id: achievement_badge_id])
        {:error, error}

      achievement_badge ->
        {:ok, achievement_badge}
    end
  end

  @doc """
  Get a achievement badge by `id`.
  """
  @since "1.0.0"
  @spec get_achievement_badge(Integer.t()) :: AchievementBadge.t() | nil | no_return
  def get_achievement_badge(achievement_badge_id), do: Repo.get(AchievementBadge, achievement_badge_id)
end
