defmodule StrawHat.Review.Repo.Migrations.CreateReviewsReactionsTable do
  use Ecto.Migration

  def change do
    create table(:reviews_reactions, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:user_id, :string, null: false)
      add(:review_id, references(:reviews, type: :binary_id, on_delete: :delete_all))
      add(:reaction_id, references(:reactions, type: :binary_id, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end
  end
end
