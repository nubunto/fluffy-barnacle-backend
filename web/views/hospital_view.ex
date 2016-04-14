defmodule Fluffy.HospitalView do
  use Fluffy.Web, :view

  def render("index.json", %{hospitals: hospitals}) do
    %{data: render_many(hospitals, Fluffy.HospitalView, "hospital.json")}
  end

  def render("show.json", %{hospital: hospital}) do
    %{data: render_one(hospital, Fluffy.HospitalView, "hospital.json")}
  end

  def render("hospital.json", %{hospital: hospital}) do
    %{id: hospital.id,
      name: hospital.name,
      lat: hospital.lat,
      lng: hospital.lng}
  end
end
