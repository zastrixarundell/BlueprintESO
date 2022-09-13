defmodule BlueprintESOWeb.Authentication.Pipeline do
  @moduledoc """
  Pipleine for Guardian
  """

  use Guardian.Plug.Pipeline,
    otp_app: :blueprint_eso,
    error_handler: BlueprintESOWeb.Authentication.ErrorHandler,
    module: BlueprintESOWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
