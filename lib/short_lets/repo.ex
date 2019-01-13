defmodule ShortLets.Repo do
  use Ecto.Repo,
    otp_app: :short_lets,
    adapter: Ecto.Adapters.Postgres
end
