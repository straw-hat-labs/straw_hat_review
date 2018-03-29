defmodule StrawHat.Review.Repo.Migrations.CreateAchievementBadgesTable do
  use Ecto.Migration

  def change do
    create table(:achievement_badges) do
      add(:name, :string, null: false)
    end

    create(unique_index(:achievement_badges, [:name], name: :achievement_badges_name_index))
  end
end
