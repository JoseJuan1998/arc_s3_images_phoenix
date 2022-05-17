defmodule Teacher.Context.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :body, :string
    field :title, :string
    field :slug, :string
    has_many :comments, Teacher.Context.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    attrs =
      attrs
      |> Map.merge(slug_map(attrs))

    post
    |> cast(attrs, [:title, :body, :slug])
    |> validate_required([:title, :body])
  end

  defp slug_map(%{"title" => title}) do
    slug =
      title
      |> String.downcase()
      |> String.replace(" ", "-")

    %{"slug" => slug}
  end

  defp slug_map(_params) do
    %{}
  end
end

# defimpl Phoenix.Param, for: Teacher.Context.Post do
#   def to_param(%{slug: slug}) do
#     "#{slug}"
#   end
# end
