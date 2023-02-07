# BlueprintESO
Phoenix app for management of blueprint cooldowns


![image](https://raw.githubusercontent.com/zastrixarundell/BlueprintESO/master/priv/static/images/blueprint.png)

## Details about the app

This is a webapp created in Phoenix using Tailwind. Auth is based on Ueberauths' implementation of Discord Oauth to allow sync accross multiple devices. 

## Starting up the server

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

The server is running on ip `0.0.0.0` to allow port-forwarding from an Oracle Cloud server.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
