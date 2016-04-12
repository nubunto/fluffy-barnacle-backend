defmodule Fluffy.PageController do
  use Fluffy.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
