defmodule StrawHat.Review.Repo.Migrations.CreateAspectsTable do
  use Ecto.Migration

  def change do
    create table(:aspects) do
      add(:name, :string, null: false)
    end

    create (unique_index(:aspects, [:name], name: :aspects_name_index))
  end
end
