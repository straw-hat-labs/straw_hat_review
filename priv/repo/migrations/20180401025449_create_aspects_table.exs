defmodule StrawHat.Review.Repo.Migrations.CreateAspectsTable do
  use Ecto.Migration

  def change do
    create table(:aspects) do
      add(:name, :string, null: false)

      timestamps()
    end

    create(index(:aspects, :name, unique: true, name: :aspects_name_index))
  end
end
