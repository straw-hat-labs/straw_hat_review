defmodule StrawHat.Review.Test.DataCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Query

      import StrawHat.Review.Test.DataCase
      import StrawHat.Review.Test.Factory

      alias StrawHat.Review.Repo
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(StrawHat.Review.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(StrawHat.Review.Repo, {:shared, self()})
    end

    :ok
  end
end
