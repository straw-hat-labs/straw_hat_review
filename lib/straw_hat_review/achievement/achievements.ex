defmodule StrawHat.Review.Achievements do
  @moduledoc """
  Interactor module that defines all the functionality for Achievements management.
  """

  use StrawHat.Review.Interactor
  alias StrawHat.Review.Achievement

  @doc """
  Gets the list of achievements.
  """
  @since "1.0.0"
  @spec get_achievements(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_achievements(pagination \\ []), do: Repo.paginate(Achievement, pagination)

  @doc """
  Creates achievement.
  """
  @since "1.0.0"
  @spec create_achievement(Achievement.achievement_attrs()) ::
          {:ok, Achievement.t()} | {:error, Ecto.Changeset.t()}
  def create_achievement(achievement_attrs) do
    %Achievement{}
    |> Achievement.changeset(achievement_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates achievement.
  """
  @since "1.0.0"
  @spec update_achievement(Achievement.t(), Achievement.achievement_attrs()) ::
          {:ok, Achievement.t()} | {:error, Ecto.Changeset.t()}
  def update_achievement(%Achievement{} = achievement, achievement_attrs) do
    achievement
    |> Achievement.changeset(achievement_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys achievement.
  """
  @since "1.0.0"
  @spec destroy_achievement(Achievement.t()) ::
          {:ok, Achievement.t()} | {:error, Ecto.Changeset.t()}
  def destroy_achievement(%Achievement{} = achievement), do: Repo.delete(achievement)

  @doc """
  Finds achievement by `id`.
  """
  @since "1.0.0"
  @spec find_achievement(String.t()) :: {:ok, Achievement.t()} | {:error, Error.t()}
  def find_achievement(achievement_id) do
    achievement_id
    |> get_achievement()
    |> StrawHat.Response.from_value(
      Error.new(
        "straw_hat_review.achievement.not_found",
        metadata: [achievement_id: achievement_id]
      )
    )
  end

  @doc """
  Gets achievement by `id`.
  """
  @since "1.0.0"
  @spec get_achievement(String.t()) :: Achievement.t() | nil | no_return
  def get_achievement(achievement_id), do: Repo.get(Achievement, achievement_id)
end
