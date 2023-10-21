defmodule ChpterPhoenix.OrdersTest do
  use ChpterPhoenix.DataCase

  alias ChpterPhoenix.Orders

  describe "orders" do
    alias ChpterPhoenix.Orders.Order

    import ChpterPhoenix.OrdersFixtures

    @invalid_attrs %{phone_number: nil, customer_name: nil, customer_email: nil, delivery_location: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{phone_number: "some phone_number", customer_name: "some customer_name", customer_email: "some customer_email", delivery_location: "some delivery_location"}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.phone_number == "some phone_number"
      assert order.customer_name == "some customer_name"
      assert order.customer_email == "some customer_email"
      assert order.delivery_location == "some delivery_location"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{phone_number: "some updated phone_number", customer_name: "some updated customer_name", customer_email: "some updated customer_email", delivery_location: "some updated delivery_location"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.phone_number == "some updated phone_number"
      assert order.customer_name == "some updated customer_name"
      assert order.customer_email == "some updated customer_email"
      assert order.delivery_location == "some updated delivery_location"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
