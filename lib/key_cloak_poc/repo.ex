defmodule KeyCloakPoc.Repo do
  use Ecto.Repo,
    otp_app: :key_cloak_poc,
    adapter: Ecto.Adapters.Postgres
end
