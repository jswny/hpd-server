defmodule Hpd.SessionControllerTest do
  use Hpd.ConnCase
  alias Hpd.Auth
  import Hpd.TestHelpers

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates new session and renders username and valid token when user is valid", %{conn: conn} do
    user = insert_user(valid_user_attrs())

    conn = post conn, session_path(conn, :create), user: %{username: valid_user_attrs().username, password: valid_user_attrs().password} 
    response = json_response(conn, 201)["data"]
    assert response["username"] == user.username 
    assert Auth.verify_token(response["token"]) == {:ok, user.id}
  end

  test "does not generate token and renders not_found error when user does not exist", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{username: "username", password: "password"} 
    response = json_response(conn, 404)
    assert response["errors"]["detail"] == "Specified user does not exist"
    refute response["token"] 
  end
  
  test "does not generate token and renders unauthorized error when password is incorrect", %{conn: conn} do
    insert_user(valid_user_attrs())

    conn = post conn, session_path(conn, :create), user: %{username: "username", password: "wrong"} 
    response = json_response(conn, 401)
    assert response["errors"]["detail"] == "Invalid username or password"
    refute response["token"] 
  end
end
