defmodule StrawHat.Review.Repo.Migrations.CreateCommentsReactionsTable do
  use Ecto.Migration

  def change do
    create table(:comments_reactions) do
      add(:comment_id, references(:comments))
      add(:reaction_id, references(:reactions))
      add(:user_id, :string, null: false)

      timestamps()
    end
  end
end
