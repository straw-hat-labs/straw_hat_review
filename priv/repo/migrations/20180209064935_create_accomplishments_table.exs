defmodule StrawHat.Review.Repo.Migrations.CreateAccomplishmentsTable do
  use Ecto.Migration

  def change do
    create table(:accomplishments) do
      add(:name, :string, null: false)
    end

    create (unique_index(:accomplishments, [:name], name: :accomplishments_name_index))
  end
end
