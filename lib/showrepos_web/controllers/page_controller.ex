defmodule ShowreposWeb.PageController do
  use ShowreposWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
