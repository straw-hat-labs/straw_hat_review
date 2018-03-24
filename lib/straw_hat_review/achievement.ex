defmodule StrawHat.Review.Achievement do
  @moduledoc """
  Interactor module that defines all the functionality for Achievement management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.Achievement

  @doc """
  Get the list of achievements.
  """
  @spec get_achievements(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_achievements(pagination \\ []), do: Repo.paginate(Achievement, pagination)

  @doc """
  Create achievement.
  """
  @spec create_achievement(Achievement.achievement_attrs()) :: {:ok, Achievement.t()} | {:error, Ecto.Changeset.t()}
  def create_achievement(achievement_attrs) do
    %Achievement{}
    |> Achievement.changeset(achievement_attrs)
    |> Repo.insert()
  end

  @doc """
  Update achievement.
  """
  @spec update_achievement(Achievement.t(), Achievement.achievement_attrs()) :: {:ok, Achievement.t()} | {:error, Ecto.Changeset.t()}
  def update_achievement(%Achievement{} = achievement, achievement_attrs) do
    achievement
    |> Achievement.changeset(achievement_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy achievement.
  """
  @spec destroy_achievement(Achievement.t()) :: {:ok, Achievement.t()} | {:error, Ecto.Changeset.t()}
  def destroy_achievement(%Achievement{} = achievement), do: Repo.delete(achievement)

  @doc """
  Find achievement by `id`.
  """
  @spec find_achievement(String.t()) :: {:ok, Achievement.t()} | {:error, Error.t()}
  def find_achievement(achievement_id) do
    case get_achievement(achievement_id) do
      nil ->
        error = Error.new("straw_hat_review.achievement.not_found", metadata: [achievement_id: achievement_id])
        {:error, error}

      achievement ->
        {:ok, achievement}
    end
  end

  @doc """
  Get achievement by `id`.
  """
  @spec get_achievement(String.t()) :: Achievement.t() | nil | no_return
  def get_achievement(achievement_id), do: Repo.get(Achievement, achievement_id)
end
