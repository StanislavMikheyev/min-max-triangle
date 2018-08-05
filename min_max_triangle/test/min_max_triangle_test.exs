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
  @result2 [
    {27, [11, 3, 6, 7]},
    {23, [2, 8, 6, 7]},
    {31, [10, 8, 6, 7]},
    {24, [9, 5, 3, 7]}
  ]


  def test_input(a) do
    [[1] | test_input_internal(a - 1, [1])]
  end

  def test_input_internal(a, _) when a <= 0 do
    []
  end

  def test_input_internal(a, l) do
    new = l ++ [(List.last(l) + 1)]
    [new | test_input_internal(a - 1, new)]
  end

  test "test_data with min option" do
    assert MinMaxTriangle.calculate(@test_data, :min) == @result1
  end

  test "test_data with max option" do
    assert MinMaxTriangle.calculate(@test_data, :max) == @result2
  end

  test "Very big input set" do
    result = test_input(500) |> MinMaxTriangle.calculate(:min)
    assert length(result) == 500
    assert hd(result) == {500, Enum.map(1..500, fn _ -> 1 end)}
  end
end
