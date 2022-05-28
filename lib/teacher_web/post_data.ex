defmodule TeacherWeb.PostData do
  import Plug.Conn
  import Ecto.Query, warn: false

  alias Teacher.Context.Post
  alias Teacher.Repo

  def init(opts) do
    Keyword.fetch(opts, :msg)
  end

  def call(conn, msg) do
    total =
      Post
      |> select([u], count(u))
      |> Repo.one()

    case msg do
      {:ok, msg} ->
        custom_msg = "#{msg} #{total}"
        assign(conn, :post_total_message, custom_msg)

      :error ->
        default_msg = "We found #{total} posts"
        assign(conn, :post_total_message, default_msg)
    end
  end
end
