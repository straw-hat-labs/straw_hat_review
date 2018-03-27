defmodule StrawHat.Review.Aspects do
  @moduledoc """
  Interactor module that defines all the functionality for Aspects management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Aspect

  @doc """
  Get the list of aspects.
  """
  @since "1.0.0"
  @spec get_aspects(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_aspects(pagination \\ []), do: Repo.paginate(Aspect, pagination)

  @doc """
  Create aspect.
  """
  @since "1.0.0"
  @spec create_aspect(Aspect.aspect_attrs()) ::
          {:ok, Aspect.t()} | {:error, Ecto.Changeset.t()}
  def create_aspect(aspect_attrs) do
    %Aspect{}
    |> Aspect.changeset(aspect_attrs)
    |> Repo.insert()
  end

  @doc """
  Update aspect.
  """
  @since "1.0.0"
  @spec update_aspect(Aspect.t(), Aspect.aspect_attrs()) ::
          {:ok, Aspect.t()} | {:error, Ecto.Changeset.t()}
  def update_aspect(%Aspect{} = aspect, aspect_attrs) do
    aspect
    |> Aspect.changeset(aspect_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy aspect.
  """
  @since "1.0.0"
  @spec destroy_aspect(Aspect.t()) ::
          {:ok, Aspect.t()} | {:error, Ecto.Changeset.t()}
  def destroy_aspect(%Aspect{} = aspect), do: Repo.delete(aspect)

  @doc """
  Find aspect by `id`.
  """
  @since "1.0.0"
  @spec find_aspect(Integer.t()) :: {:ok, Aspect.t()} | {:error, Error.t()}
  def find_aspect(aspect_id) do
    case get_aspect(aspect_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.aspect.not_found",
            metadata: [aspect_id: aspect_id]
          )

        {:error, error}

      aspect ->
        {:ok, aspect}
    end
  end

  @doc """
  Get aspect by `id`.
  """
  @since "1.0.0"
  @spec get_aspect(Integer.t()) :: Aspect.t() | nil | no_return
  def get_aspect(aspect_id), do: Repo.get(Aspect, aspect_id)
end
