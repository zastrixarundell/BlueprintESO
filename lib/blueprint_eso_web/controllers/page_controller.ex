defmodule BlueprintESOWeb.PageController do
  use BlueprintESOWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
