defmodule ImgLoaderWeb.CustomComponents do
  use Phoenix.Component

  alias ImgLoader.Schemas.Image
  alias ImgLoader.Repo

  def images(assigns) do
    ~H"""
    <%= for image <- Repo.all(Image) do %>
      <img src={parse_src(image)} alt={image.name} />
    <% end %>
    """
  end

  def parse_src(image) do
    binary = Base.encode64(image.image)

    "data:image/#{image.extension};base64,#{binary}"
  end

  def upload_button(assigns) do
    ~H"""
    <button
      type="submit"
      class="flex-none group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
    >
      <span class="absolute inset-0 rounded-2xl bg-zinc-50 transition group-hover:bg-zinc-100 sm:group-hover:scale-105" />
      <span class="relative flex items-center gap-4 sm:flex-col">
        <svg viewBox="0 0 24 24" fill="none" aria-hidden="true" class="h-6 w-6">
          <line
            x1="3"
            y1="12"
            x2="12"
            y2="4"
            fill="#18181B"
            fill-opacity=".15"
            stroke="#18181B"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="21"
            y1="12"
            x2="12"
            y2="4"
            fill="#18181B"
            fill-opacity=".15"
            stroke="#18181B"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="12"
            y1="24"
            x2="12"
            y2="4"
            fill="#18181B"
            fill-opacity=".15"
            stroke="#18181B"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
        </svg>
        Upload image
      </span>
    </button>
    """
  end

  def upload_form(assigns) do
    ~H"""
    <form id="upload-form" phx-submit="save" phx-change="validate">
      <.live_file_input upload={@uploads.image} type="file" name="file" />
      <%!-- <button type="submit">Upload</button> --%>
      <.upload_button />
    </form>
    """
  end
end
