defmodule ShortLets.Repo.Migrations.UpdatePhotosTable do
  use Ecto.Migration

  def change do
  	alter table(:photos) do
	  	add :image_url, :string	
		remove :image
	end
  end
end