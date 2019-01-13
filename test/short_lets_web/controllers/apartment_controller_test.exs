defmodule ShortLetsWeb.ApartmentControllerTest do
  use ShortLetsWeb.ConnCase

  alias ShortLets.Accounts

  @create_attrs %{address: "some address", description: "some description", name: "some name"}
  @update_attrs %{address: "some updated address", description: "some updated description", name: "some updated name"}
  @invalid_attrs %{address: nil, description: nil, name: nil}

  def fixture(:apartment) do
    {:ok, apartment} = Accounts.create_apartment(@create_attrs)
    apartment
  end

  describe "index" do
    test "lists all apartments", %{conn: conn} do
      conn = get(conn, Routes.apartment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Apartments"
    end
  end

  describe "new apartment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.apartment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Apartment"
    end
  end

  describe "create apartment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.apartment_path(conn, :create), apartment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.apartment_path(conn, :show, id)

      conn = get(conn, Routes.apartment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Apartment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.apartment_path(conn, :create), apartment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Apartment"
    end
  end

  describe "edit apartment" do
    setup [:create_apartment]

    test "renders form for editing chosen apartment", %{conn: conn, apartment: apartment} do
      conn = get(conn, Routes.apartment_path(conn, :edit, apartment))
      assert html_response(conn, 200) =~ "Edit Apartment"
    end
  end

  describe "update apartment" do
    setup [:create_apartment]

    test "redirects when data is valid", %{conn: conn, apartment: apartment} do
      conn = put(conn, Routes.apartment_path(conn, :update, apartment), apartment: @update_attrs)
      assert redirected_to(conn) == Routes.apartment_path(conn, :show, apartment)

      conn = get(conn, Routes.apartment_path(conn, :show, apartment))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, apartment: apartment} do
      conn = put(conn, Routes.apartment_path(conn, :update, apartment), apartment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Apartment"
    end
  end

  describe "delete apartment" do
    setup [:create_apartment]

    test "deletes chosen apartment", %{conn: conn, apartment: apartment} do
      conn = delete(conn, Routes.apartment_path(conn, :delete, apartment))
      assert redirected_to(conn) == Routes.apartment_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.apartment_path(conn, :show, apartment))
      end
    end
  end

  defp create_apartment(_) do
    apartment = fixture(:apartment)
    {:ok, apartment: apartment}
  end
end
