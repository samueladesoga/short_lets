defmodule ShortLetsWeb.PageController do
  use ShortLetsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
