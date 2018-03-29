defmodule StrawHat.Review.Repo.Migrations.CreateReviewAspectsTable do
  use Ecto.Migration

  def change do
    create table(:review_aspects) do
      add(:review_id, references(:reviews), on_delete: :delete_all)
      add(:aspect_id, references(:aspects), on_delete: :delete_all)
      add(:comment, :string, null: false)
      add(:score, :integer, null: false)
    end
  end
end
