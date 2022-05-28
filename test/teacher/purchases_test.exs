defmodule Teacher.PurchasesTest do
  use Teacher.DataCase

  alias Teacher.Purchases

  describe "customers" do
    alias Teacher.Purchases.Customer

    import Teacher.PurchasesFixtures

    @invalid_attrs %{email: nil, stripe_customer_id: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Purchases.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Purchases.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{
        email: "some email",
        stripe_customer_id: "some stripe_customer_id"
      }

      assert {:ok, %Customer{} = customer} =
               Purchases.create_customer(valid_attrs)

      assert customer.email == "some email"
      assert customer.stripe_customer_id == "some stripe_customer_id"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Purchases.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()

      update_attrs = %{
        email: "some updated email",
        stripe_customer_id: "some updated stripe_customer_id"
      }

      assert {:ok, %Customer{} = customer} =
               Purchases.update_customer(customer, update_attrs)

      assert customer.email == "some updated email"
      assert customer.stripe_customer_id == "some updated stripe_customer_id"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Purchases.update_customer(customer, @invalid_attrs)

      assert customer == Purchases.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Purchases.delete_customer(customer)

      assert_raise Ecto.NoResultsError, fn ->
        Purchases.get_customer!(customer.id)
      end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Purchases.change_customer(customer)
    end
  end
end
