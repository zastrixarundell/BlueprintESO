defmodule BlueprintESOWeb.Auth.DiscordController do
  use BlueprintESOWeb, :controller
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_failure: _fails}} = _conn, _params) do
    IO.inspect("Well... something made a mistake, welp!")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = _conn, _params) do
    IO.inspect("Logged in! The auth code is")
    IO.inspect(auth)
  end
end
