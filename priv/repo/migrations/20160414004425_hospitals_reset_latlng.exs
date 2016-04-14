defmodule Fluffy.Repo.Migrations.HospitalsResetLatlng do
  use Ecto.Migration

  def change do
    alter table(:hospitals) do
      remove :lat
      remove :lng

      add :lat, :string
      add :lng, :string
    end
  end
end
