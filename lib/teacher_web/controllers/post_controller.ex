defmodule TeacherWeb.PostController do
  use TeacherWeb, :controller

  alias Teacher.Repo
  alias Teacher.Context
  alias Teacher.Mailer
  alias Teacher.Email
  alias Teacher.Context.Post

  def index(conn, params \\ %{}) do
    page =
      Post
      |> Repo.paginate(params)

    render(conn, "index.html", posts: page.entries, page: page)
  end

  def new(conn, _params) do
    changeset = Context.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Context.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post =
      Repo.get_by!(Post, slug: id)
      |> Repo.preload(:comments)

    comment_changeset = Teacher.Context.Comment.changeset(%Teacher.Context.Comment{})
    render(conn, "show.html", post: post, comment_changeset: comment_changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get_by!(Post, slug: id)
    changeset = Context.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get_by!(Post, slug: id)

    case Context.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  defp send_removal_notification(post) do
    Email.post_removal_email(post)
    |> Mailer.deliver_later()
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get_by!(Post, slug: id)
    {:ok, _post} = Context.delete_post(post)
    send_removal_notification(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
