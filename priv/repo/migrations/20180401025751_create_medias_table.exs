defmodule StrawHat.Review.Repo.Migrations.CreateMediasTable do
  use Ecto.Migration

  def change do
    create table(:medias, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:content_type, :string, null: false)
      add(:file_name, :string, null: false)
      add(:file, :string, null: false)
      add(:review_id, references(:reviews, type: :binary_id, on_delete: :delete_all), null: false)

      timestamps(type: :utc_datetime)
    end
  end
end
