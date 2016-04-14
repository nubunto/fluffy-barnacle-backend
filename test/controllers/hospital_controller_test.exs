defmodule Fluffy.HospitalControllerTest do
  use Fluffy.ConnCase

  alias Fluffy.Hospital
  @valid_attrs %{lat: "120.5", lng: "120.5", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, hospital_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    hospital = Repo.insert! %Hospital{}
    conn = get conn, hospital_path(conn, :show, hospital)
    assert json_response(conn, 200)["data"] == %{"id" => hospital.id,
      "name" => hospital.name,
      "lat" => hospital.lat,
      "lng" => hospital.lng}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, hospital_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, hospital_path(conn, :create), hospital: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Hospital, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hospital_path(conn, :create), hospital: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    hospital = Repo.insert! %Hospital{}
    conn = put conn, hospital_path(conn, :update, hospital), hospital: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Hospital, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    hospital = Repo.insert! %Hospital{}
    conn = put conn, hospital_path(conn, :update, hospital), hospital: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    hospital = Repo.insert! %Hospital{}
    conn = delete conn, hospital_path(conn, :delete, hospital)
    assert response(conn, 204)
    refute Repo.get(Hospital, hospital.id)
  end
end
