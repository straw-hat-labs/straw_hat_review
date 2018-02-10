defmodule StrawHat.Review.Repo.Migrations.CreateTagsTable do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add(:name, :string, null: false)
    end

    create (unique_index(:tags, [:name], name: :tags_name_index))
  end
end
