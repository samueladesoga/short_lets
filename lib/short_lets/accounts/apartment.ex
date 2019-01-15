defmodule ShortLets.Accounts.Apartment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "apartments" do
    field :address, :string
    field :description, :string
    field :name, :string
    has_many :photos, ShortLets.Accounts.Photo

    timestamps()
  end

  @doc false
  def changeset(apartment, attrs) do
    apartment
    |> cast(attrs, [:name, :description, :address])
    |> validate_required([:name, :description, :address])
  end
end
