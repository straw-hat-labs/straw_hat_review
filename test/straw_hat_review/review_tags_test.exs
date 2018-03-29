defmodule StrawHat.Review.ReviewTagsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.ReviewTag

  test "validate changeset with nil data" do
    assert %Ecto.Changeset{errors: _errors} = %ReviewTag{} |> ReviewTag.changeset(%{})
  end
end
