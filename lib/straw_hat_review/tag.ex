defmodule StrawHat.Review.Tag do
  @moduledoc """
  Interactor module that defines all the functionality for Tag management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.Tag

  @doc """
  Get the list of tags.
  """
  @spec get_tags(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_tags(pagination \\ []), do: Repo.paginate(Tag, pagination)

  @doc """
  Create a tag.
  """
  @spec create_tag(Tag.tag_attrs()) :: {:ok, Tag.t()} | {:error, Ecto.Changeset.t()}
  def create_tag(tag_attrs) do
    %Tag{}
    |> Tag.changeset(tag_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a tag.
  """
  @spec update_tag(Tag.t(), Tag.tag_attrs()) :: {:ok, Tag.t()} | {:error, Ecto.Changeset.t()}
  def update_tag(%Tag{} = tag, tag_attrs) do
    tag
    |> Tag.changeset(tag_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a tag.
  """
  @spec destroy_tag(Tag.t()) :: {:ok, Tag.t()} | {:error, Ecto.Changeset.t()}
  def destroy_tag(%Tag{} = tag), do: Repo.delete(tag)

  @doc """
  Find a tag by `id`.
  """
  @spec find_tag(String.t()) :: {:ok, Tag.t()} | {:error, Error.t()}
  def find_tag(tag_id) do
    case get_tag(tag_id) do
      nil ->
        error = Error.new("straw_hat_review.tag.not_found", metadata: [tag_id: tag_id])
        {:error, error}

      tag ->
        {:ok, tag}
    end
  end

  @doc """
  Get a tag by `id`.
  """
  @spec get_tag(String.t()) :: Tag.t() | nil | no_return
  def get_tag(tag_id), do: Repo.get(Tag, tag_id)
end
