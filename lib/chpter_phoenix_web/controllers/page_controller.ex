defmodule ChpterPhoenixWeb.PageController do
  use ChpterPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
