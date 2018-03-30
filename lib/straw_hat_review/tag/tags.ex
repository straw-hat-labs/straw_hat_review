defmodule StrawHat.Review.Tags do
  @moduledoc """
  Interactor module that defines all the functionality for Tags management.
  """

  use StrawHat.Review.Interactor
  alias StrawHat.Review.Tag

  @doc """
  Get the list of tags.
  """
  @since "1.0.0"
  @spec get_tags(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_tags(pagination \\ []), do: Repo.paginate(Tag, pagination)

  @doc """
  Create a tag.
  """
  @since "1.0.0"
  @spec create_tag(Tag.tag_attrs()) :: {:ok, Tag.t()} | {:error, Ecto.Changeset.t()}
  def create_tag(tag_attrs) do
    %Tag{}
    |> Tag.changeset(tag_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a tag.
  """
  @since "1.0.0"
  @spec update_tag(Tag.t(), Tag.tag_attrs()) :: {:ok, Tag.t()} | {:error, Ecto.Changeset.t()}
  def update_tag(%Tag{} = tag, tag_attrs) do
    tag
    |> Tag.changeset(tag_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a tag.
  """
  @since "1.0.0"
  @spec destroy_tag(Tag.t()) :: {:ok, Tag.t()} | {:error, Ecto.Changeset.t()}
  def destroy_tag(%Tag{} = tag), do: Repo.delete(tag)

  @doc """
  Find a tag by `id`.
  """
  @since "1.0.0"
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
  @since "1.0.0"
  @spec get_tag(String.t()) :: Tag.t() | nil | no_return
  def get_tag(tag_id), do: Repo.get(Tag, tag_id)
end
