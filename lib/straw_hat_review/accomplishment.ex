defmodule StrawHat.Review.Accomplishment do
  @moduledoc """
  Interactor module that defines all the functionality for Accomplishment management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.Accomplishment

  @doc """
  Get the list of accomplishments.
  """
  @spec get_accomplishments(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_accomplishments(pagination \\ []), do: Repo.paginate(Accomplishment, pagination)

  @doc """
  Create accomplishment.
  """
  @spec create_accomplishment(Accomplishment.accomplishment_attrs()) ::
          {:ok, Accomplishment.t()} | {:error, Ecto.Changeset.t()}
  def create_accomplishment(accomplishment_attrs) do
    %Accomplishment{}
    |> Accomplishment.changeset(accomplishment_attrs)
    |> Repo.insert()
  end

  @doc """
  Update accomplishment.
  """
  @spec update_accomplishment(Accomplishment.t(), Accomplishment.accomplishment_attrs()) ::
          {:ok, Accomplishment.t()} | {:error, Ecto.Changeset.t()}
  def update_accomplishment(%Accomplishment{} = accomplishment, accomplishment_attrs) do
    accomplishment
    |> Accomplishment.changeset(accomplishment_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy accomplishment.
  """
  @spec destroy_accomplishment(Accomplishment.t()) ::
          {:ok, Accomplishment.t()} | {:error, Ecto.Changeset.t()}
  def destroy_accomplishment(%Accomplishment{} = accomplishment), do: Repo.delete(accomplishment)

  @doc """
  Find accomplishment by `id`.
  """
  @spec find_accomplishment(String.t()) :: {:ok, Accomplishment.t()} | {:error, Error.t()}
  def find_accomplishment(accomplishment_id) do
    case get_accomplishment(accomplishment_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.accomplishment.not_found",
            metadata: [accomplishment_id: accomplishment_id]
          )

        {:error, error}

      accomplishment ->
        {:ok, accomplishment}
    end
  end

  @doc """
  Get accomplishment by `id`.
  """
  @spec get_accomplishment(String.t()) :: Accomplishment.t() | nil | no_return
  def get_accomplishment(accomplishment_id), do: Repo.get(Accomplishment, accomplishment_id)
end
