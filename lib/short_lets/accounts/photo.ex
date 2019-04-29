defmodule ShortLets.Accounts.Photo do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset


  schema "photos" do
    field :image, ShortLets.Photo.Type
    field :uuid, :string

    belongs_to :apartment, ShortLets.Accounts.Apartment

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> Map.update(:uuid, Ecto.UUID.generate, fn val -> val || Ecto.UUID.generate end)
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image])
  end
end
