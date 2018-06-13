defmodule StrawHat.Review.Repo.Migrations.CreateAspectsTable do
  use Ecto.Migration

  def change do
    create table(:aspects) do
      add(:name, :string, null: false)

      timestamps(type: :utc_datetime)
    end

    create(index(:aspects, :name, unique: true))
  end
end
