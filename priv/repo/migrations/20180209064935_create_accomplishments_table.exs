defmodule StrawHat.Review.Repo.Migrations.CreateAccomplishmentsTable do
  use Ecto.Migration

  def change do
    create table(:accomplishments) do
      add(:name, :string, null: false)
    end

    create(index(:accomplishments, [:name], unique: true))
  end
end
