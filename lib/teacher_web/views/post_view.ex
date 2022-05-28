defmodule TeacherWeb.PostView do
  use TeacherWeb, :view

  alias Earmark.Options
  alias TeacherWeb.DisplayImage

  def as_html(txt) do
    txt
    |> Earmark.as_html!(%Options{smartypants: false})
    |> raw
  end

  def display_image(post) do
    {post.display_image, post}
    |> DisplayImage.url()
    |> img_tag()
  end
end
