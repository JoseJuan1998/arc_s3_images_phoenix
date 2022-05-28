defmodule TeacherWeb.PurchaseController do
  use TeacherWeb, :controller

  alias Teacher.Repo
  alias Teacher.Context
  alias Teacher.Purchases
  alias Teacher.Purchases.Customer
  alias Teacher.Purchases.Address

  def receipt(conn, params) do
    customer =
      params["customer_id"]
      |> Purchases.get_customer!()
      |> Repo.preload(:post)

    post = customer.post
    render(conn, "receipt.html", customer: customer, post: post)
  end

  def create(conn, params) do
    IO.inspect(params)
    post = Context.get_post!(params["post_id"])

    customer =
      params
      |> customer_changeset()
      |> Ecto.Changeset.put_assoc(:post, post)
      |> Ecto.Changeset.put_assoc(:ship_address, address_changeset(params))
      |> Repo.insert!()

    case Purchases.charge_customer(customer, 5000) do
      {:ok, _charge} ->
        conn
        |> redirect(
          to: Routes.purchase_path(conn, :receipt, customer_id: customer.id)
        )

      {:error, _msg} ->
        conn
        |> put_flash(:error, "We couldn't charge your card")
        |> redirect(to: Routes.post_path(conn, :index))
    end
  end

  defp address_changeset(attrs) do
    address_attrs = %{
      city: attrs["stripeShippingAddressCity"],
      country: attrs["stripeShippingAddressCountry"],
      line: attrs["stripeShippingAddressLine1"],
      name: attrs["stripeShippingName"],
      state: attrs["stripeShippingAddressState"],
      zip: attrs["stripeShippingAddressZip"]
    }

    Address.changeset(%Address{}, address_attrs)
  end

  defp customer_changeset(attrs) do
    customer_attrs = %{
      email: attrs["stripeEmail"],
      stripe_customer_id:
        Purchases.create_stripe_customer(
          attrs["stripeEmail"],
          attrs["stripeToken"]
        )
    }

    Customer.changeset(%Customer{}, customer_attrs)
  end
end
