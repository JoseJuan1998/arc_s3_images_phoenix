defmodule Teacher.Email do
  use Bamboo.Phoenix, view: TeacherWeb.EmailView

  def post_removal_email(post) do
    new_email()
    |> from("no-reply@example.com")
    |> to("hello@example.com")
    # |> put_html_layout({TeacherWeb.LayoutView, "email.html"})
    |> subject("A movie was removed")
    |> assign(:post, post)
    |> render("post_removal.html")
  end
end
