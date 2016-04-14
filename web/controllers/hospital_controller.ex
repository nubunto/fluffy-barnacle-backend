defmodule Fluffy.HospitalController do
  use Fluffy.Web, :controller

  alias Fluffy.Hospital

  plug :scrub_params, "hospital" when action in [:create, :update]

  def index(conn, _params) do
    hospitals = Repo.all(Hospital)
    render(conn, "index.json", hospitals: hospitals)
  end

  def create(conn, %{"hospital" => hospital_params}) do
    changeset = Hospital.changeset(%Hospital{}, hospital_params)

    case Repo.insert(changeset) do
      {:ok, hospital} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", hospital_path(conn, :show, hospital))
        |> render("show.json", hospital: hospital)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Fluffy.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hospital = Repo.get!(Hospital, id)
    render(conn, "show.json", hospital: hospital)
  end

  def update(conn, %{"id" => id, "hospital" => hospital_params}) do
    hospital = Repo.get!(Hospital, id)
    changeset = Hospital.changeset(hospital, hospital_params)

    case Repo.update(changeset) do
      {:ok, hospital} ->
        render(conn, "show.json", hospital: hospital)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Fluffy.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hospital = Repo.get!(Hospital, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(hospital)

    send_resp(conn, :no_content, "")
  end
end
