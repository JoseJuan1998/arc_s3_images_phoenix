defmodule Teacher.Purchases.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teacher.Context.Post
  alias Teacher.Purchases.Address

  schema "customers" do
    field :email, :string
    field :stripe_customer_id, :string
    belongs_to :post, Post
    has_one :ship_address, Address

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :stripe_customer_id])
    |> validate_required([:email, :stripe_customer_id])
  end
end
