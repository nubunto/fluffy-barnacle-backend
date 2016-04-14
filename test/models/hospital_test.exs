defmodule Fluffy.HospitalTest do
  use Fluffy.ModelCase

  alias Fluffy.Hospital

  @valid_attrs %{lat: "120.5", lng: "120.5", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Hospital.changeset(%Hospital{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Hospital.changeset(%Hospital{}, @invalid_attrs)
    refute changeset.valid?
  end
end
