defmodule ShortLets.Repo.Migrations.CreateApartments do
  use Ecto.Migration

  def change do
    create table(:apartments) do
      add :name, :string
      add :description, :text
      add :address, :text

      timestamps()
    end

  end
end
