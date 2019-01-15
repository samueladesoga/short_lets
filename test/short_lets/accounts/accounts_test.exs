defmodule ShortLets.AccountsTest do
  use ShortLets.DataCase

  alias ShortLets.Accounts

  describe "apartments" do
    alias ShortLets.Accounts.Apartment

    @valid_attrs %{address: "some address", description: "some description", name: "some name"}
    @update_attrs %{address: "some updated address", description: "some updated description", name: "some updated name"}
    @invalid_attrs %{address: nil, description: nil, name: nil}

    def apartment_fixture(attrs \\ %{}) do
      {:ok, apartment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_apartment()

      apartment
    end

    test "list_apartments/0 returns all apartments" do
      apartment = apartment_fixture()
      assert Accounts.list_apartments() == [apartment]
    end

    test "get_apartment!/1 returns the apartment with given id" do
      apartment = apartment_fixture()
      assert Accounts.get_apartment!(apartment.id) == apartment
    end

    test "create_apartment/1 with valid data creates a apartment" do
      assert {:ok, %Apartment{} = apartment} = Accounts.create_apartment(@valid_attrs)
      assert apartment.address == "some address"
      assert apartment.description == "some description"
      assert apartment.name == "some name"
    end

    test "create_apartment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_apartment(@invalid_attrs)
    end

    test "update_apartment/2 with valid data updates the apartment" do
      apartment = apartment_fixture()
      assert {:ok, %Apartment{} = apartment} = Accounts.update_apartment(apartment, @update_attrs)
      assert apartment.address == "some updated address"
      assert apartment.description == "some updated description"
      assert apartment.name == "some updated name"
    end

    test "update_apartment/2 with invalid data returns error changeset" do
      apartment = apartment_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_apartment(apartment, @invalid_attrs)
      assert apartment == Accounts.get_apartment!(apartment.id)
    end

    test "delete_apartment/1 deletes the apartment" do
      apartment = apartment_fixture()
      assert {:ok, %Apartment{}} = Accounts.delete_apartment(apartment)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_apartment!(apartment.id) end
    end

    test "change_apartment/1 returns a apartment changeset" do
      apartment = apartment_fixture()
      assert %Ecto.Changeset{} = Accounts.change_apartment(apartment)
    end
  end

  describe "photos" do
    alias ShortLets.Accounts.Photo

    @valid_attrs %{apartment_id: "some apartment_id", image: "some image"}
    @update_attrs %{apartment_id: "some updated apartment_id", image: "some updated image"}
    @invalid_attrs %{apartment_id: nil, image: nil}

    def photo_fixture(attrs \\ %{}) do
      {:ok, photo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_photo()

      photo
    end

    test "list_photos/0 returns all photos" do
      photo = photo_fixture()
      assert Accounts.list_photos() == [photo]
    end

    test "get_photo!/1 returns the photo with given id" do
      photo = photo_fixture()
      assert Accounts.get_photo!(photo.id) == photo
    end

    test "create_photo/1 with valid data creates a photo" do
      assert {:ok, %Photo{} = photo} = Accounts.create_photo(@valid_attrs)
      assert photo.apartment_id == "some apartment_id"
      assert photo.image == "some image"
    end

    test "create_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_photo(@invalid_attrs)
    end

    test "update_photo/2 with valid data updates the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{} = photo} = Accounts.update_photo(photo, @update_attrs)
      assert photo.apartment_id == "some updated apartment_id"
      assert photo.image == "some updated image"
    end

    test "update_photo/2 with invalid data returns error changeset" do
      photo = photo_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_photo(photo, @invalid_attrs)
      assert photo == Accounts.get_photo!(photo.id)
    end

    test "delete_photo/1 deletes the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{}} = Accounts.delete_photo(photo)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_photo!(photo.id) end
    end

    test "change_photo/1 returns a photo changeset" do
      photo = photo_fixture()
      assert %Ecto.Changeset{} = Accounts.change_photo(photo)
    end
  end
end
