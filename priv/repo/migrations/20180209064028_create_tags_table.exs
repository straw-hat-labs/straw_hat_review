defmodule StrawHat.Review.Repo.Migrations.CreateTagsTable do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add(:name, :string, null: false)
    end

    create(index(:tags, [:name], unique: true))
  end
end
