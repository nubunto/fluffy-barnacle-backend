defmodule Fluffy.Repo.Migrations.HospitalAddPlaceId do
  use Ecto.Migration

  def change do
    alter table(:hospitals) do
      add :place_id, :integer
    end
  end
end
