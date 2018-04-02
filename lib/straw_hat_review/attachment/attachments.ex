defmodule StrawHat.Review.Attachments do
  @moduledoc """
  Interactor module that defines all the functionality for Attachments management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Attachment

  @doc """
  Get the list of attachments.
  """
  @since "1.0.0"
  @spec get_attachments(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_attachments(pagination \\ []), do: Repo.paginate(Attachment, pagination)

  @doc """
  Create attachment.
  """
  @since "1.0.0"
  @spec create_attachment(Attachment.attachment_attrs()) ::
          {:ok, Attachment.t()} | {:error, Ecto.Changeset.t()}
  def create_attachment(attachment_attrs) do
    %Attachment{}
    |> Attachment.changeset(attachment_attrs)
    |> Repo.insert()
  end

  @doc """
  Update attachment.
  """
  @since "1.0.0"
  @spec update_attachment(Attachment.t(), Attachment.attachment_attrs()) ::
          {:ok, Attachment.t()} | {:error, Ecto.Changeset.t()}
  def update_attachment(%Attachment{} = attachment, attachment_attrs) do
    attachment
    |> Attachment.changeset(attachment_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy attachment.
  """
  @since "1.0.0"
  @spec destroy_attachment(Attachment.t()) ::
          {:ok, Attachment.t()} | {:error, Ecto.Changeset.t()}
  def destroy_attachment(%Attachment{} = attachment), do: Repo.delete(attachment)

  @doc """
  Find attachment by `id`.
  """
  @since "1.0.0"
  @spec find_attachment(Integer.t()) :: {:ok, Attachment.t()} | {:error, Error.t()}
  def find_attachment(attachment_id) do
    case get_attachment(attachment_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.attachment.not_found",
            metadata: [attachment_id: attachment_id]
          )

        {:error, error}

      attachment ->
        {:ok, attachment}
    end
  end

  @doc """
  Get attachment by `id`.
  """
  @since "1.0.0"
  @spec get_attachment(Integer.t()) :: Attachment.t() | nil | no_return
  def get_attachment(attachment_id), do: Repo.get(Attachment, attachment_id)
end
