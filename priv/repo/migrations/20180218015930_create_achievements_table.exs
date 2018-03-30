defmodule StrawHat.Review.Repo.Migrations.CreateAchievementsTable do
  use Ecto.Migration

  def change do
    create table(:achievements) do
      add(:owner_id, :string, null: false)
      timestamps()

      add(
        :achievement_badge_id,
        references(:achievement_badges),
        primary_key: true,
        on_delete: :delete_all
      )
    end

    create(index(:achievements, [:owner_id, :achievement_badge_id], unique: true))
  end
end
