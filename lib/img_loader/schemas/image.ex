defmodule ImgLoader.Schemas.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :name, :string
    field :extension, :string
    field :image, :binary
  end

  def changeset(images, attrs) do
    images |> cast(attrs, [:name, :extension, :image])
  end
end
