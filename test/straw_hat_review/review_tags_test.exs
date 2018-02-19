defmodule StrawHat.Review.Test.ReviewTagsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Schema.ReviewTag

  test "validate changeset with nil data" do
   assert %Ecto.Changeset{errors: _errors}  = %ReviewTag{} |> ReviewTag.changeset(%{})
  end
end
