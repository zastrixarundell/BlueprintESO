defmodule BlueprintESOWeb.PageController do
  use BlueprintESOWeb, :controller

  alias BlueprintESO.Accounts

  require IEx

  def index(conn, _params) do
    current_account = Authentication.get_current_account(conn)

    render(conn, "index.html", current_account: current_account, characters: Accounts.list_account_characters(current_account))
  end
end
