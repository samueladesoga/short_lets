defmodule ShortLets.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :image, :string
      add :apartment_id, :string

      timestamps()
    end

  end
end
