defmodule ChpterPhoenix.Chpter do
  def initiate_payment(
        api_key,
        phone_number,
        name,
        email,
        amount,
        location,
        callback_url
      ) do
    header = header(api_key)

    body =
      body(
        phone_number,
        email,
        name,
        location,
        amount,
        callback_url
      )

    url = "https://api.chpter.co/v1/initiate/mpesa-payment"

    request_body = Poison.encode!(body)

    HTTPoison.post(url, request_body, header)
  end

  defp header(api_key) do
    [
      {
        "Content-Type",
        "application/json"
      },
      {
        "Api-Key",
        api_key
      }
    ]
  end

  defp body(
         phone_number,
         email,
         name,
         location,
         amount,
         callback_url
       ) do
    %{
      customer_details: %{
        "full_name" => name,
        "location" => location,
        "phone_number" => phone_number,
        "email" => email
      },
      products: [],
      amount: %{
        "currency" => "KES",
        "delivery_fee" => 0.0,
        "discount_fee" => 0.0,
        "total" => 1
      },
      callback_details: %{
        "transaction_reference" => phone_number,
        "callback_url" => callback_url
      }
    }
  end

  def check_for_payment(transaction_reference, api_endpoint) do
    body = HTTPoison.get!("http://localhost:4000/api/transactions")

    customer_record =
      Poison.decode!(body.body)["data"]
      |> Enum.find(fn record -> record["transaction_reference"] == transaction_reference end)

    customer_record

    if customer_record != nil do
      customer_record
    else
      Process.sleep(1000)
      check_for_payment(transaction_reference, api_endpoint)
    end
  end
end
