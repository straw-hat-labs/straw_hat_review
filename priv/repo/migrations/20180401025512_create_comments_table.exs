defmodule StrawHat.Review.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:comment, :text, null: false)
      add(:owner_id, :string, null: false)
      add(:review_id, references(:reviews, type: :binary_id, on_delete: :delete_all), null: false)

      timestamps(type: :utc_datetime)
    end

    create(index(:comments, [:review_id, :owner_id], unique: true))
  end
end
