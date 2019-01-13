defmodule ShortLetsWeb.ApartmentController do
  use ShortLetsWeb, :controller

  alias ShortLets.Accounts
  alias ShortLets.Accounts.Apartment

  def index(conn, _params) do
    apartments = Accounts.list_apartments()
    render(conn, "index.html", apartments: apartments)
  end

  def new(conn, _params) do
    changeset = Accounts.change_apartment(%Apartment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"apartment" => apartment_params}) do
    case Accounts.create_apartment(apartment_params) do
      {:ok, apartment} ->
        conn
        |> put_flash(:info, "Apartment created successfully.")
        |> redirect(to: Routes.apartment_path(conn, :show, apartment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    apartment = Accounts.get_apartment!(id)
    render(conn, "show.html", apartment: apartment)
  end

  def edit(conn, %{"id" => id}) do
    apartment = Accounts.get_apartment!(id)
    changeset = Accounts.change_apartment(apartment)
    render(conn, "edit.html", apartment: apartment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "apartment" => apartment_params}) do
    apartment = Accounts.get_apartment!(id)

    case Accounts.update_apartment(apartment, apartment_params) do
      {:ok, apartment} ->
        conn
        |> put_flash(:info, "Apartment updated successfully.")
        |> redirect(to: Routes.apartment_path(conn, :show, apartment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", apartment: apartment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    apartment = Accounts.get_apartment!(id)
    {:ok, _apartment} = Accounts.delete_apartment(apartment)

    conn
    |> put_flash(:info, "Apartment deleted successfully.")
    |> redirect(to: Routes.apartment_path(conn, :index))
  end
end
