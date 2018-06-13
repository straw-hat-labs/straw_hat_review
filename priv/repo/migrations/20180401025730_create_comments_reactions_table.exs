defmodule StrawHat.Review.Repo.Migrations.CreateCommentsReactionsTable do
  use Ecto.Migration

  def change do
    create table(:comments_reactions, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:user_id, :string, null: false)
      add(:comment_id, references(:comments, type: :binary_id, on_delete: :delete_all))
      add(:reaction_id, references(:reactions, type: :binary_id, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end

    create(index(:comments_reactions, [:comment_id, :user_id], unique: true))
  end
end
