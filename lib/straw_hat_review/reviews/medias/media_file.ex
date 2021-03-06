defmodule StrawHat.Review.MediaFile do
  @moduledoc """
  Arc module that defines a media file.
  """

  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]

  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png .mp4) |> Enum.member?(Path.extname(file.file_name))
  end
end
