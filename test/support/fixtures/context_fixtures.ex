defmodule Teacher.ContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Teacher.Context` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> Teacher.Context.create_post()

    post
  end
end
