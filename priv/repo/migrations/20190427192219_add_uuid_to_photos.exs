defmodule ShortLets.Repo.Migrations.AddUuidToPhotos do
  use Ecto.Migration

  def change do
	alter table(:photos) do
		remove :apartment_id
		remove :image_url
		remove :inserted_at
		remove :updated_at
		add :image, :string
  	add :uuid, :string
  	add :apartment_id, references(:apartments, on_delete: :delete_all)

      	timestamps()
  	end

  	create index(:photos, [:apartment_id])
  end
end
