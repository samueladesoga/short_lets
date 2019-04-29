defmodule ShortLets.Repo.Migrations.UpdatePhotosApartmentTable do
  use Ecto.Migration

  def change do
  	alter table(:photos) do
  		remove :apartment_id
    	add :apartment_id, references(:apartments), null: false
  	end
  end
end
