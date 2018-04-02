defmodule StrawHat.Review.Reactions do
  @moduledoc """
  Interactor module that defines all the functionality for Reactions management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Reaction

  @doc """
  Get the list of reactions.
  """
  @since "1.0.0"
  @spec get_reactions(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_reactions(pagination \\ []), do: Repo.paginate(Reaction, pagination)

  @doc """
  Create reaction.
  """
  @since "1.0.0"
  @spec create_reaction(Reaction.reaction_attrs()) ::
          {:ok, Reaction.t()} | {:error, Ecto.Changeset.t()}
  def create_reaction(reaction_attrs) do
    %Reaction{}
    |> Reaction.changeset(reaction_attrs)
    |> Repo.insert()
  end

  @doc """
  Update reaction.
  """
  @since "1.0.0"
  @spec update_reaction(Reaction.t(), Reaction.reaction_attrs()) ::
          {:ok, Reaction.t()} | {:error, Ecto.Changeset.t()}
  def update_reaction(%Reaction{} = reaction, reaction_attrs) do
    reaction
    |> Reaction.changeset(reaction_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy reaction.
  """
  @since "1.0.0"
  @spec destroy_reaction(Reaction.t()) ::
          {:ok, Reaction.t()} | {:error, Ecto.Changeset.t()}
  def destroy_reaction(%Reaction{} = reaction), do: Repo.delete(reaction)

  @doc """
  Find reaction by `id`.
  """
  @since "1.0.0"
  @spec find_reaction(Integer.t()) :: {:ok, Reaction.t()} | {:error, Error.t()}
  def find_reaction(reaction_id) do
    case get_reaction(reaction_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.reaction.not_found",
            metadata: [reaction_id: reaction_id]
          )

        {:error, error}

      reaction ->
        {:ok, reaction}
    end
  end

  @doc """
  Get reaction by `id`.
  """
  @since "1.0.0"
  @spec get_reaction(Integer.t()) :: Reaction.t() | nil | no_return
  def get_reaction(reaction_id), do: Repo.get(Reaction, reaction_id)
end
