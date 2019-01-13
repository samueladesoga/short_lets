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
end
