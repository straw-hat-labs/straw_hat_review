defmodule StrawHat.Review.Repo.Migrations.CreateReviewsReactionsTable do
  use Ecto.Migration

  def change do
    create table(:reviews_reactions) do
      add(:review_id, references(:comments))
      add(:reaction_id, references(:reactions))
      add(:user_id, :string, null: false)

      timestamps()
    end
  end
end
