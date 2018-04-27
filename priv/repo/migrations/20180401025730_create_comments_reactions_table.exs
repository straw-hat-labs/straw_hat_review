defmodule StrawHat.Review.Repo.Migrations.CreateCommentsReactionsTable do
  use Ecto.Migration

  def change do
    create table(:comments_reactions) do
      add(:user_id, :string, null: false)
      add(:comment_id, references(:comments))
      add(:reaction_id, references(:reactions))

      timestamps()
    end

    create(index(:comments_reactions, [:comment_id, :user_id], unique: true))
  end
end
