defmodule Fluffy.Hospital do
  use Fluffy.Web, :model

  schema "hospitals" do
    field :name
    field :lat
    field :lng

    field :place_id

    timestamps
  end

  @required_fields ~w(name lat lng)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
