defmodule StrawHat.Review.Repo.Migrations.CreateReviewTagsTable do
  use Ecto.Migration

  def change do
    create table(:review_tags, primary_key: false) do
      add(:review_id, references(:reviews), primary_key: true, on_delete: :delete_all)
      add(:tag_id, references(:tags), primary_key: true, on_delete: :delete_all)
    end
  end
end
