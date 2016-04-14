defmodule Fluffy.IndexView do
  use Fluffy.Web, :view

  def render("index.json", %{message: message}) do
    %{data: %{
      message: message
    }}
  end

  def render("nearest.json", %{lat: lat, lng: lng}) do
    # TODO: Call Google Places API.
    {:ok, ret} = Fluffy.Places.nearest_hospitals(lat, lng)
    ret
  end
end
