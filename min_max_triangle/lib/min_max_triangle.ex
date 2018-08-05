defmodule MinMaxTriangle do

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

  def calculate(input, opt) do
    calculate_internal([], input, opt)
  end

  def calculate_internal([], [[h] | t], opt) do
    calculate_internal([{h, [h]}], t, opt)
  end

  def calculate_internal(current, [h | t], opt) do
    calc_row(current, h, opt)
    |> calculate_internal(t, opt)
  end

  def calculate_internal(current, [], _) do
    current
  end

  def calc_row(current = [a | _], next = [c | t], opt) do
    [triangle_compare(a, c, opt)] ++ calc_row_internal(current, t, opt)
  end

  def calc_row_internal([a | t1 = [b | _]], [c | t2], opt) do
    [triangle_compare(a, b, c, opt)] ++ calc_row_internal(t1, t2, opt)
  end

  def calc_row_internal([a], [c], opt) do
    [triangle_compare(a, c, opt)]
  end

  def triangle_compare(a, b, c, opt) do
    case opt do
      :min -> min(a, b)
      :max -> max(a, b)
    end |> triangle_compare(c, opt)
  end

  def triangle_compare({sum, path}, c, _) do
    {sum + c, [c | path]}
  end

end