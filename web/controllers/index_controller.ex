defmodule Fluffy.IndexController do
  use Fluffy.Web, :controller

  def index(conn, _params) do
    render(conn, "index.json", message: "hello there!")
  end

  def nearest(conn, %{"lat" => lat, "lng" => lng}) do
    render(conn, "nearest.json", lat: lat, lng: lng)
  end
end
