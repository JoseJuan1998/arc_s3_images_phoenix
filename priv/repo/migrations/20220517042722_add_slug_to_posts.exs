defmodule Teacher.Repo.Migrations.AddSlugToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :slug, :string
    end

    create unique_index(:posts, :slug)
  end
end
