defmodule BlueprintESO.Repo do
  use Ecto.Repo,
    otp_app: :blueprint_eso,
    adapter: Ecto.Adapters.Postgres
end
