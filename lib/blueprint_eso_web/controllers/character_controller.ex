defmodule BlueprintESOWeb.CharacterController do
  use BlueprintESOWeb, :controller

  alias BlueprintESO.Accounts

  plug :find_character when not action in [:new, :show]

  def new(conn, _), do: render(conn, "new.html", current_account: Authentication.get_current_account(conn))

  def reset(conn, _) do
    conn.assigns[:char]
    |> Accounts.update_character(%{collected_at: nil})
    |> IO.inspect()

    conn
    |> put_flash(:info, "Reset timer on user!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def cooldown(conn, %{"id" => _id, "type" => type}) do
    IO.inspect(String.to_existing_atom(type))
    conn.assigns[:char]
    |> Accounts.update_character(%{collected_at: DateTime.utc_now(), collected_type: String.to_existing_atom(type)})

    conn
    |> put_flash(:info, "Put character on cooldown!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def delete(conn, %{"id" => _id}) do
    conn.assigns[:char]
    |> Accounts.delete_character()

    conn
    |> put_flash(:info, "Deleted character!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp find_character(%Plug.Conn{params: %{"id" => id}} = conn, _params) do
    case Accounts.get_character(id) do
      {:ok, char} ->
        conn
        |> assign(:char, char)
      {:error, _} ->
        conn
        |> put_flash(:error, "Character not found")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
