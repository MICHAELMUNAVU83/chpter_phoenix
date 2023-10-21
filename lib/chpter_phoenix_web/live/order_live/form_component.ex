defmodule ChpterPhoenixWeb.OrderLive.FormComponent do
  use ChpterPhoenixWeb, :live_component

  alias ChpterPhoenix.Orders
  alias ChpterPhoenix.Chpter

  @impl true
  def update(%{order: order} = assigns, socket) do
    changeset = Orders.change_order(order)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"order" => order_params}, socket) do
    changeset =
      socket.assigns.order
      |> Orders.change_order(order_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"order" => order_params}, socket) do
    save_order(socket, socket.assigns.action, order_params)
  end

  defp save_order(socket, :edit, order_params) do
    case Orders.update_order(socket.assigns.order, order_params) do
      {:ok, _order} ->
        {:noreply,
         socket
         |> put_flash(:info, "Order updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_order(socket, :new, order_params) do
    timestamp =
      Timex.local()
      |> Timex.format!("{YYYY}{0M}{0D}{h24}{m}{s}")

    transaction_reference = order_params["phone_number"] <> timestamp

    case Chpter.initiate_payment(
           "pk_4aff02227456f6b499820c2621ae181c9e35666d25865575fef47622265dcbb9",
           "254740769596",
           "Michael Munavu",
           "michaelmunavu83@gmail.com",
           1,
           "Nairobi",
           "https://720a-102-135-173-116.ngrok-free.app/api/transactions",
           transaction_reference
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        customer_record =
          Chpter.check_for_payment(
            transaction_reference,
            "http://localhost:4000/api/transactions"
          )

        if customer_record["success"] == true do
          case Orders.create_order(order_params) do
            {:ok, _order} ->
              {:noreply,
               socket
               |> put_flash(:info, "Order created successfully")
               |> push_redirect(to: socket.assigns.return_to)}

            {:error, %Ecto.Changeset{} = changeset} ->
              {:noreply, assign(socket, changeset: changeset)}
          end
        else
          {:noreply,
           socket
           |> put_flash(:error, "Payment Failed , #{customer_record["message"]}")
           |> push_redirect(to: socket.assigns.return_to)}
        end

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payment Failed ")}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payment Failed , Timeout error")}
    end
  end
end
