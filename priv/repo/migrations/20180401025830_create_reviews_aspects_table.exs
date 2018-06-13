defmodule StrawHat.Review.Repo.Migrations.CreateReviewsAspectsTable do
  use Ecto.Migration

  def change do
    create table(:reviews_aspects, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:score, :integer, null: false)
      add(:review_id, references(:reviews, type: :binary_id, on_delete: :delete_all))
      add(:aspect_id, references(:aspects, type: :binary_id, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end
  end
end
