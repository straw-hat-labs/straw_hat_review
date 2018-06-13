defmodule StrawHat.Review.Repo.Migrations.CreateReactionsTable do
  use Ecto.Migration

  def change do
    create table(:reactions, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)

      timestamps(type: :utc_datetime)
    end

    create(index(:reactions, :name, unique: true))
  end
end
