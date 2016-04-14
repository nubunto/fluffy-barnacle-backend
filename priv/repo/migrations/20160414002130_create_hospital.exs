defmodule Fluffy.Repo.Migrations.CreateHospital do
  use Ecto.Migration

  def change do
    create table(:hospitals) do
      add :name, :string
      add :lat, :float
      add :lng, :float

      timestamps
    end

  end
end
