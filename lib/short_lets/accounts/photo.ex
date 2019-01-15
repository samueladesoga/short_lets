defmodule ShortLets.Accounts.Photo do
  use Ecto.Schema
  import Ecto.Changeset


  schema "photos" do
    field :apartment_id, :string
    field :image, :string
    belongs_to :apartment, ShortLets.Accounts.Apartment

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:image, :apartment_id])
    |> validate_required([:image, :apartment_id])
  end
end
