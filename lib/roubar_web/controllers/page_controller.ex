defmodule RoubarWeb.PageController do
  use RoubarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
