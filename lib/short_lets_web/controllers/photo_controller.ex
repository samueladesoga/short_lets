require IEx
defmodule ShortLetsWeb.PhotoController do
  use ShortLetsWeb, :controller

  alias ShortLets.Accounts
  alias ShortLets.Accounts.Photo

  def index(conn, _params) do
    photos = Accounts.list_photos()
    render(conn, "index.html", photos: photos)
  end

  def new(conn, _params) do
    changeset = Accounts.change_photo(%Photo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"photo" => %{"image" => file_params } = photo_params}) do
    file_uuid = UUID.uuid4(:hex)
    photo_file_name = file_params.filename
    unique_file_name = "#{file_uuid}-#{photo_file_name}"
    {:ok, image_binary} = File.read(file_params.path)
    bucket_name = System.get_env("BUCKET_NAME")
    image = ExAws.S3.put_object(bucket_name, unique_file_name, image_binary)
            |> ExAws.request!
    updated_params = photo_params 
                      |> Map.update(image, file_params, 
                        fn _value -> "https://#{bucket_name}.s3.amazonaws.com/#{unique_file_name}"
                      end)        
    IEx.pry              
    case Accounts.create_photo(photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo created successfully.")
        |> redirect(to: Routes.photo_path(conn, :show, photo))

      {:error, %Ecto.Changeset{} = changeset} ->
        IEx.pry
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    photo = Accounts.get_photo!(id)
    render(conn, "show.html", photo: photo)
  end

  def edit(conn, %{"id" => id}) do
    photo = Accounts.get_photo!(id)
    changeset = Accounts.change_photo(photo)
    render(conn, "edit.html", photo: photo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "photo" => photo_params}) do
    photo = Accounts.get_photo!(id)

    case Accounts.update_photo(photo, photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo updated successfully.")
        |> redirect(to: Routes.photo_path(conn, :show, photo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", photo: photo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    photo = Accounts.get_photo!(id)
    {:ok, _photo} = Accounts.delete_photo(photo)

    conn
    |> put_flash(:info, "Photo deleted successfully.")
    |> redirect(to: Routes.photo_path(conn, :index))
  end
end
