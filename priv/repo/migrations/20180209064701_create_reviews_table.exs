defmodule StrawHat.Review.Repo.Migrations.CreateReviewsTable do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add(:score, :integer, null: false)

      # the object or user that receive the review
      add(:reviewee_id, :string, null: false)

      # the user that make the comment
      add(:reviewer_id, :string, null: false)

      # tag for mark the review for example customer, performer etc...
      add(:type, :string)

      add(:comment, :string)
      add(:review_id, references(:reviews), on_delete: :delete_all)

      timestamps()
    end
  end
end
