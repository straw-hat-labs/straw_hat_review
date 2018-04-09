defmodule StrawHat.Review.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(StrawHat.Review.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: StrawHat.Review.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
