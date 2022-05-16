defmodule TeacherWeb.Api.V1.PostController do
  use TeacherWeb, :controller

  alias Teacher.Context.Post
  alias Teacher.Context
  alias Teacher.Repo

  def index(conn, _params) do
    posts = Context.list_posts()

    render(conn, "index.json", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Context.get_post!(id)

    render(conn, "show.json", post: post)
  end
end
