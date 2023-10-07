defmodule Echat.Repo do
  use Ecto.Repo,
    otp_app: :echat,
    adapter: Ecto.Adapters.Postgres
end
