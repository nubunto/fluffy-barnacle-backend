defmodule Fluffy.Places do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    {:ok, System.get_env("API_KEY")}
  end

  # Client API
  def nearest_hospitals(lat, lng) do
    GenServer.call(__MODULE__, {:nearest, {lat, lng}})
  end

  def debug do
    GenServer.call(__MODULE__, :debug)
  end

  # Server API
  def handle_call({:nearest, {lat, lng}}, _from, api_key) do
    %{body: result} = HTTPotion.get "https://maps.googleapis.com/maps/api/place/textsearch/json?type=hospital&location=#{lat},#{lng}&radius=10000&key=#{api_key}"
    result = Poison.Parser.parse!(result)
    {:reply, {:ok, result}, api_key}
  end
end
