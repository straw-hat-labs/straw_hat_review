defmodule StrawHat.Review.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add(:comment, :string, null: false)
      add(:owner_id, :string, null: false)
      add(:review_id, references(:reviews), null: false)

      timestamps()
    end

    create(index(:comments, [:review_id, :owner_id], unique: true))
  end
end
