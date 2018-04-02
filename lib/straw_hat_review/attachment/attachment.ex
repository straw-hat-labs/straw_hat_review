defmodule StrawHat.Review.Attachment do
  @moduledoc """
  Represents a Attachment Ecto Schema.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Review

  @typedoc """
  - `content_type`: The type content of the attachment.
  - `file_name`: The name use to identify the file.
  - `file`: The file content.
  - `review`: `t:StrawHat.Review.Review.t/0` associated with the current attachment.
  - `review_id`: The review used for the attachment.
  """
  @type t :: %__MODULE__{
          content_type: String.t(),
          file_name: String.t(),
          file: String.t(),
          review: Review.t() | Ecto.Association.NotLoaded.t(),
          review_id: Integer.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type attachment_attrs :: %{
          content_type: String.t(),
          file_name: String.t(),
          file: String.t(),
          review_id: Integer.t()
        }

  @required_fields ~w(content_type file_name file review_id)a

  schema "attachments" do
    field(:content_type, :string)
    field(:file_name, :string)
    field(:file, :string)
    belongs_to(:review, Review)

    timestamps()
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Attachment.
  """
  @since "1.0.0"
  @spec changeset(t, attachment_attrs) :: Ecto.Changeset.t()
  def changeset(attachment, attachment_attrs) do
    attachment
    |> cast(attachment_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:review)
  end
end
