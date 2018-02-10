defmodule StrawHat.Review.Repo.Migrations.CreateReviewAccomplishmentsTable do
  use Ecto.Migration

  def change do
    create table(:review_accomplishments, primary_key: false) do
      add(:review_id, references(:reviews), primary_key: true, on_delete: :delete_all)
      add(:accomplishment_id, references(:accomplishments), primary_key: true, on_delete: :delete_all)
    end
  end
end
