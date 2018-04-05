defmodule StrawHat.Review.Media do
  @moduledoc """
  Represents a Media Ecto Schema.
  """

  use StrawHat.Review.Schema
  use Arc.Ecto.Schema
  alias StrawHat.Review.Review

  @typedoc """
  - `content_type`: The type content of the media.
  - `file_name`: The name use to identify the file.
  - `file`: The file content.
  - `review`: `t:StrawHat.Review.Review.t/0` associated with the current media.
  - `review_id`: The review used for the media.
  """
  @type t :: %__MODULE__{
          content_type: String.t(),
          file_name: String.t(),
          file: StrawHat.Review.MediaFile.t(),
          review: Review.t() | Ecto.Association.NotLoaded.t(),
          review_id: Integer.t()
        }

  @typedoc """
  Check `t:t/0` type for more information about the keys.
  """
  @type media_attrs :: %{
          content_type: String.t(),
          file_name: String.t(),
          file: StrawHat.Review.MediaFile.t(),
          review_id: Integer.t()
        }

  @required_fields ~w(content_type file_name file review_id)a

  schema "medias" do
    field(:content_type, :string)
    field(:file_name, :string)
    field(:file, StrawHat.Review.MediaFile.Type)
    belongs_to(:review, Review)

    timestamps()
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Media.
  """
  @since "1.0.0"
  @spec changeset(t, media_attrs) :: Ecto.Changeset.t()
  def changeset(media, media_attrs) do
    media
    |> cast(media_attrs, @required_fields)
    |> validate_required(@required_fields)
    |> cast_attachments(media_attrs, [:file])
    |> assoc_constraint(:review)
  end
end
