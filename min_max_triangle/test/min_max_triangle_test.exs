defmodule MinMaxTriangleTest do
  use ExUnit.Case
  doctest MinMaxTriangle

  @test_data MinMaxTriangle.Main.read_file("test/test_data")
  @result1 [
    {27, [11, 3, 6, 7]},
    {18, [2, 3, 6, 7]},
    {25, [10, 5, 3, 7]},
    {24, [9, 5, 3, 7]}
  ]

  test "Test algorithm on test_data with min option" do
    assert MinMaxTriangle.calculate(@test_data, :min) == @result1
  end

#  test "Test algorithm on test_data with max option" do
#    input = File.open!("test/test_data", [:read], fn stream -> MinMaxTriangle.Main.read_until_eof(stream) end)
#    assert MinMaxTriangle.calculate(input, :max) == []
#  end
end
