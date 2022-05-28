defmodule Teacher.Repo.Migrations.AddDisplayImageToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :display_image, :string
    end
  end
end
