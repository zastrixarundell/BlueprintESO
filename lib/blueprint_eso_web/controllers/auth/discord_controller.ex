defmodule BlueprintESOWeb.Auth.DiscordController do
  use BlueprintESOWeb, :controller
  plug Ueberauth

  alias BlueprintESO.Accounts
  alias BlueprintESOWeb.Authentication

  require IEx

  @spec logout(Plug.Conn.t(), any) :: nil | Plug.Conn.t()
  def logout(conn, _) do
    if Authentication.get_current_account(conn) do
      conn
      |> Authentication.log_out()
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = _conn, _params) do
    IO.inspect("Well... something made a mistake, welp!")
  end

  def callback(%{assigns: %{ueberauth_auth: %Ueberauth.Auth{} = auth}} = conn, _params) do
    case Accounts.create_or_update_discord(auth) do
      {:ok, discord} ->
        conn
        |> Authentication.log_in(discord)
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _} ->
        IO.inspect("Something done fucked up!")
    end
  end
end
