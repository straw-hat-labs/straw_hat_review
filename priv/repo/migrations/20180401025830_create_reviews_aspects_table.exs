defmodule StrawHat.Review.Repo.Migrations.CreateReviewsAspectsTable do
  use Ecto.Migration

  def change do
    create table(:reviews_aspects) do
      add(:score, :integer, null: false)
      add(:review_id, references(:reviews))
      add(:aspect_id, references(:aspects))

      timestamps(type: :utc_datetime)
    end
  end
end
