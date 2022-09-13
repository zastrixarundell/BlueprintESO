defmodule BlueprintESOWeb.Authentication do
  @moduledoc """
  Implementation for Guardian
  """
  use Guardian, otp_app: :blueprint_eso

  alias BlueprintESO.Accounts

  def log_in(conn, account), do: __MODULE__.Plug.sign_in(conn, account)

  def log_out(conn), do: __MODULE__.Plug.sign_out(conn)

  def get_current_account(conn), do: __MODULE__.Plug.current_resource(conn)

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.uid)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_discord(id) do
      {:snowflake, discord} ->
        {:ok, discord}
      {:error, _} ->
        {:error, :resource_not_found}
    end
  end

end
