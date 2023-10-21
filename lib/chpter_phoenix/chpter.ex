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
end
