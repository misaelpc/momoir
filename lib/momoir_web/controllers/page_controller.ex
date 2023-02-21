defmodule MomoirWeb.PageController do
  use MomoirWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
