defmodule StrawHat.Review.AttachmentFile do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]

  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png .mp4) |> Enum.member?(Path.extname(file.file_name))
  end

  def filename(version, {file, scope}) do
    file_name = Path.basename(file.file_name, Path.extname(file.file_name))
    "#{scope.id}_#{version}_#{file_name}"
  end
end
