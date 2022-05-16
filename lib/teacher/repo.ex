defmodule Teacher.Repo do
  use Ecto.Repo,
    otp_app: :teacher,
    adapter: Ecto.Adapters.Postgres

  use Scrivener,
    page_size: 4
end
