defmodule ShowreposWeb.PageController do
  use ShowreposWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", token: get_csrf_token())
  end

  def getRepos(conn, %{"username" => username}) do
    text conn, "#{username}"
  end
end
