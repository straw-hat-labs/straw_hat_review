defmodule StrawHat.Review.Repo.Migrations.CreateReviewsTable do
  use Ecto.Migration

  def change do
    create table(:reviews, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      # the object or user that receive the review
      add(:reviewee_id, :string, null: false)
      # the user that make the comment
      add(:reviewer_id, :string, null: false)
      add(:comment, :text, null: false)

      timestamps(type: :utc_datetime)
    end
  end
end
