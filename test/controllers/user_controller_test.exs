defmodule Hpd.UserControllerTest do
  use Hpd.ConnCase
  alias Hpd.User
  import Hpd.TestHelpers

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: valid_user_attrs()
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, username: valid_user_attrs().username)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: invalid_user_attrs()
    assert json_response(conn, 422)["errors"] != %{}
  end
end
