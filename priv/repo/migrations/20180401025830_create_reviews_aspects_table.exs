defmodule StrawHat.Review.Repo.Migrations.CreateReviewsAspectsTable do
  use Ecto.Migration

  def change do
    create table(:reviews_aspects) do
      add(:review_id, references(:reviews))
      add(:aspect_id, references(:aspects))
      add(:score, :integer, null: false)

      timestamps()
    end
  end
end
