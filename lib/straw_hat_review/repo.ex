defmodule StrawHat.Review.Repo do
  @moduledoc """
  Defines a repository.

  Check `Ecto.Repo` documentation for learn more about this module.
  """
  use Ecto.Repo, otp_app: :straw_hat_review
  use Scrivener, page_size: 25
end
