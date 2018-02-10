defmodule StrawHat.Review.Helpful do
  @moduledoc """
  Interactor module that defines all the functionality for Helpful management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.Helpful

  @doc """
  Get the list of helpful.
  """
  @spec get_helpfuly(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_helpfuly(pagination \\ []), do: Repo.paginate(Helpful, pagination)

  @doc """
  Create a helpful.
  """
  @spec create_helpful(Helpful.helpful_attrs()) :: {:ok, Helpful.t()} | {:error, Ecto.Changeset.t()}
  def create_helpful(helpful_attrs) do
    %Helpful{}
    |> Helpful.changeset(helpful_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a helpful.
  """
  @spec update_helpful(Helpful.t(), Helpful.helpful_attrs()) :: {:ok, Helpful.t()} | {:error, Ecto.Changeset.t()}
  def update_helpful(%Helpful{} = helpful, helpful_attrs) do
    helpful
    |> Helpful.changeset(helpful_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a helpful.
  """
  @spec destroy_helpful(Helpful.t()) :: {:ok, Helpful.t()} | {:error, Ecto.Changeset.t()}
  def destroy_helpful(%Helpful{} = helpful), do: Repo.delete(helpful)

  @doc """
  Find a helpful by `id`.
  """
  @spec find_helpful(String.t()) :: {:ok, Helpful.t()} | {:error, Error.t()}
  def find_helpful(helpful_id) do
    case get_helpful(helpful_id) do
      nil ->
        error = Error.new("straw_hat_review.helpful.not_found", metadata: [helpful_id: helpful_id])
        {:error, error}

      helpful ->
        {:ok, helpful}
    end
  end

  @doc """
  Get a helpful by `id`.
  """
  @spec get_helpful(String.t()) :: Helpful.t() | nil | no_return
  def get_helpful(helpful_id), do: Repo.get(Helpful, helpful_id)
end
