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
  - `file`: `t:StrawHat.Review.MediaFile.t/0` the file representation in arc.
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
          file: StrawHat.Review.MediaFile.t(),
          review_id: Integer.t()
        }

  schema "medias" do
    field(:content_type, :string)
    field(:file_name, :string)
    field(:file, StrawHat.Review.MediaFile.Type)
    belongs_to(:review, Review)

    timestamps()
  end

  @doc """
  Validates the attributes and return a Ecto.Changeset for the current Media.
  """
  @since "1.0.0"
  @spec changeset(t, %Plug.Upload{}) :: Ecto.Changeset.t()
  def changeset(media, %Plug.Upload{} = file) do
    # TODO: I am not happy with Arc at all
    # replace Arc all at once from the application.
    media
    |> change()
    |> cast_attachments(%{file: file}, [:file])
    |> put_change(:content_type, file.content_type)
    |> put_change(:file_name, file.filename)
    |> assoc_constraint(:review)
  end
end
