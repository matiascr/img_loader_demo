defmodule ImgLoader.Repo.Migrations.CreateImagesTable do
  use Ecto.Migration

  def change do
    drop table(:images) do
    end

    create table(:images) do
      add :name, :string
      add :extension, :string
      add :image, :binary
    end
  end
end
