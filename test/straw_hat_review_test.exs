defmodule StrawHat.ReviewTest do
  use ExUnit.Case
  doctest StrawHat.Review

  test "greets the world" do
    assert StrawHat.Review.hello() == :world
  end
end
