defmodule FarmEventWorker do
  def handle(event) when is_map(event) do
    zone = Map.get(event, "zone", "unknown")
    type = Map.get(event, "type", "unspecified")
    IO.puts("Received #{type} event for #{zone}")
    :ok
  end
end

FarmEventWorker.handle(%{"type" => "soil_reading", "zone" => "north-field"})
