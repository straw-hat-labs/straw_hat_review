defmodule StrawHat.Review.Repo.Migrations.CreateRecommendationTable do
  use Ecto.Migration

  def change do
    create table(:recommendations) do
      add(:type, :string, null: false)
      add(:review_id, references(:reviews), null: false)
      add(:user_id, :string, null: false)
      add(:comment, :string, null: false)
    end

    create(index(:recommendations, [:review_id, :user_id], unique: true))
  end
end
