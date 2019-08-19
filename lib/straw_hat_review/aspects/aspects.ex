defmodule StrawHat.Review.Aspects do
  @moduledoc """
  Interactor module that defines all the functionality for Aspects management.
  """

  use StrawHat.Review.Interactor
  alias StrawHat.Review.Aspect

  @doc """
  Gets the list of aspects.
  """
  @spec get_aspects(Scrivener.Config.t() | keyword()) :: Scrivener.Page.t()
  def get_aspects(pagination \\ []), do: Repo.paginate(Aspect, pagination)

  @doc """
  Creates an aspect.
  """
  @spec create_aspect(Aspect.aspect_attrs()) :: {:ok, Aspect.t()} | {:error, Ecto.Changeset.t()}
  def create_aspect(aspect_attrs) do
    %Aspect{}
    |> Aspect.changeset(aspect_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an aspect.
  """
  @spec update_aspect(Aspect.t(), Aspect.aspect_attrs()) ::
          {:ok, Aspect.t()} | {:error, Ecto.Changeset.t()}
  def update_aspect(%Aspect{} = aspect, aspect_attrs) do
    aspect
    |> Aspect.changeset(aspect_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys an aspect.
  """
  @spec destroy_aspect(Aspect.t()) :: {:ok, Aspect.t()} | {:error, Ecto.Changeset.t()}
  def destroy_aspect(%Aspect{} = aspect), do: Repo.delete(aspect)

  @doc """
  Finds an aspect by `id`.
  """
  @spec find_aspect(Integer.t()) :: {:ok, Aspect.t()} | {:error, Error.t()}
  def find_aspect(aspect_id) do
    aspect_id
    |> get_aspect()
    |> Response.from_value(
      Error.new(
        "straw_hat_review.aspect.not_found",
        metadata: [aspect_id: aspect_id]
      )
    )
  end

  @doc """
  Gets an aspect by `id`.
  """
  @spec get_aspect(Integer.t()) :: Aspect.t() | nil | no_return
  def get_aspect(aspect_id), do: Repo.get(Aspect, aspect_id)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking aspect changes.
  """
  @spec change_aspect(Aspect.t()) :: Ecto.Changeset.t()
  def change_aspect(%Aspect{} = aspect) do
    Aspect.changeset(aspect, %{})
  end
end
