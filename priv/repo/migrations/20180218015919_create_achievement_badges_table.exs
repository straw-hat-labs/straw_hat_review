defmodule StrawHat.Review.Repo.Migrations.CreateAchievementBadgesTable do
  use Ecto.Migration

  def change do
    create table(:achievement_badges) do
      add(:name, :string, null: false)
    end

    create(index(:achievement_badges, :name, unique: true))
  end
end
