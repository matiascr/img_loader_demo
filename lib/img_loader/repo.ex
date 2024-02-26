defmodule ImgLoader.Repo do
  use Ecto.Repo,
    otp_app: :img_loader,
    adapter: Ecto.Adapters.Postgres
end
