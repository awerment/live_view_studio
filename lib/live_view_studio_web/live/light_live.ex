defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    IO.puts("MOUNT #{inspect(self())}")
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    IO.puts("RENDER #{inspect(self())}")

    ~L"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style="width: <%= @brightness %>%">
          <%= @brightness %>
        </span>
      </div>
      <button phx-click="off">
        <img src="images/light-off.svg">
      </button>
      <button phx-click="down">
        <img src="images/down.svg">
      </button>
      <button phx-click="up">
        <img src="images/up.svg">
      </button>
      <button phx-click="on">
        <img src="images/light-on.svg">
      </button>
    </div>
    """
  end

  def handle_event("on", _meta, socket) do
    IO.puts("ON #{inspect(self())}")
    {:noreply, assign(socket, :brightness, 100)}
  end

  def handle_event("up", _meta, socket) do
    {:noreply, update(socket, :brightness, &min(&1 + 10, 100))}
  end

  def handle_event("down", _meta, socket) do
    {:noreply, update(socket, :brightness, &max(&1 - 10, 0))}
  end

  def handle_event("off", _meta, socket) do
    {:noreply, assign(socket, :brightness, 0)}
  end
end
