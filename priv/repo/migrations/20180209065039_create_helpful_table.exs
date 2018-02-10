defmodule StrawHat.Review.Repo.Migrations.CreateHelpfulTable do
  use Ecto.Migration

  def change do
    create table(:helpful) do
      add(:classification, :string, null: false)
      add(:review_id, references(:reviews), null: false)
      add(:user_id, :string, null: false)
      add(:comment, :string, null: false)
    end

    create(index(:helpful, [:reviews_id, :user_id], unique: true))
  end
end
