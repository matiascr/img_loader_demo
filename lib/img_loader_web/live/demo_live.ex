defmodule ImgLoaderWeb.DemoLive do
  use Phoenix.LiveView

  import ImgLoaderWeb.CustomComponents

  alias ImgLoader.Repo
  alias ImgLoader.Schemas.Image

  def handle_event("validate", value, socket) do
    value |> dbg()

    socket.assigns.uploads.image.entries |> dbg()

    {:noreply, socket}
  end

  def handle_event("save", _params, socket) do
    case uploaded_entries(socket, :image) do
      {[_ | _] = entries, []} ->
        uploaded_files =
          for entry <- entries do
            consume_uploaded_entry(socket, entry, fn %{path: path} ->
              # dest = Path.join("priv/static/uploads", Path.basename(path))
              contents = File.read!(path)

              # name, extension, image
              {:ok, {entry.client_name, entry.client_type, contents}}
            end)
          end

        [{name, extension, image}] = uploaded_files

        {:ok, _} = Repo.insert(%Image{name: name, extension: extension, image: image})

        {:noreply, socket}

      _ ->
        {:noreply, socket}
    end
  end

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(changeset: &Image.changeset/2)
      |> allow_upload(:image, accept: ~w(.jpg .jpeg .png))
    }
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="mt-10 flex-1 items-center text-center max-w-full text-sm text-white font-semibold">
        Image loader prototype
      </h1>
      <div class="flex justify-center items-center">
        <div class="sm:w-auto">
          <.upload_form uploads={@uploads} />
          <.images />
        </div>
      </div>
      <.images />
    </div>
    """
  end
end
