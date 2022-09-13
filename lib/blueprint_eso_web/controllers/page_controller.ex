defmodule BlueprintESOWeb.PageController do
  use BlueprintESOWeb, :controller

  require IEx

  def index(conn, _params) do
    current_account = Authentication.get_current_account(conn)
    # IEx.pry()
    render(conn, "index.html", current_account: current_account)
  end
end
