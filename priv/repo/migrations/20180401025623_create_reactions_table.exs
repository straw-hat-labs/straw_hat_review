defmodule StrawHat.Review.Repo.Migrations.CreateReactionsTable do
  use Ecto.Migration

  def change do
    create table(:reactions) do
      add(:name, :string, null: false)

      timestamps()
    end

    create(index(:reactions, :name, unique: true, name: :reactions_name_index))
  end
end
