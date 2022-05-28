defmodule TeacherWeb.DisplayImage do
  use Arc.Definition
  use Arc.Ecto.Definition

  @acl :public_read
  @versions [:primary, :thumbnail]

  def transform(:primary, {_file, _movie}) do
    {:convert, "-resize 50%"}
  end

  def transform(:thumbnail, {_file, _movie}) do
    {:convert, "-resize 25%"}
  end

  def validate({file, _movie}) do
    file_extension = file.file_name
    |> Path.extname()
    |> String.downcase()

    Enum.member?([".png"], file_extension)
  end

  def s3_object_headers(version, {file, _movie}) do
    %{content_type: MIME.from_path(file.file_name)}
  end

  def storage_dir(version, {_file, movie}) do
    title = movie.title |> String.replace(" ", "-")
    "images/movies/display-images/#{version}/#{title}"
  end

  def default_url(:primary, _movie) do
    "http://placehold.it/350x200"
  end

  def default_url(:thumbnail, _movie) do
    "http://placehold.it/175x100"
  end
end
