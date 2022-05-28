defmodule Teacher.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :email, :string
      add :stripe_customer_id, :string
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:customers, [:post_id])
  end
end
