defmodule ShortLets.Accounts.Photo do
  use Ecto.Schema
  import Ecto.Changeset


  schema "photos" do
    field :image_url, :string
    belongs_to :apartment, ShortLets.Accounts.Apartment

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:image_url, :apartment_id])
    |> validate_required([:image_url, :apartment_id])
  end
end
