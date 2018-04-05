defmodule StrawHat.Review.Repo.Migrations.CreateMediasTable do
  use Ecto.Migration

  def change do
    create table(:medias) do
      add(:content_type, :string, null: false)
      add(:file_name, :string, null: false)
      add(:file, :string, null: false)
      add(:review_id, references(:reviews), null: false)

      timestamps()
    end
  end
end
