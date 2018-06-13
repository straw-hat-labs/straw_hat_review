defmodule StrawHat.Review.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add(:comment, :text, null: false)
      add(:owner_id, :string, null: false)
      add(:review_id, references(:reviews), null: false)

      timestamps(type: :utc_datetime)
    end

    create(index(:comments, [:review_id, :owner_id], unique: true))
  end
end
