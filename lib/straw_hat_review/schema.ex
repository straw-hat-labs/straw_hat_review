defmodule StrawHat.Review.Schema do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
    end
  end
end
