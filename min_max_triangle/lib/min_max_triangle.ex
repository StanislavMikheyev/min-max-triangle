defmodule MinMaxTriangle do

  @doc """
  Calculate minimal or maximal triangle path

  ## Examples

      iex> MinMaxTriangle.calculate([[1], [3, 2], [6, 5, 4]], :max)
      [{10, [6, 3, 1]}, {9, [5, 3, 1]}, {7, [4, 2, 1]}]
  """
  def calculate(input, opt) do
    calculate_internal([], input, opt)
  end

  @doc """

  Go thorught a triangle row by row calculating best sum/path for each element in the next row using current row

  arg1 - final results for current row, all elements are in form of {sum, path} where `sum`
  is a min/max sum to get to an element and `path` is a path from top to get to the element
  arg2 - following rows, 2d list, eg [[1],[1,2],[1,2,3]]
  arg3 - :min or :max
  """

  # For the first row just turn it into an element, eg if the first row is [7] then it will be turned into [7, [7]].
  defp calculate_internal([], [[h] | t], opt) do
    calculate_internal([{h, [h]}], t, opt)
  end

  # For any intermediate row call calc_row with current and next row as arguments
  defp calculate_internal(current, [h | t], opt) do
    calc_row(current, h, opt)
    |> calculate_internal(t, opt)
  end

  # For the last row just return current
  defp calculate_internal(current, [], _) do
    current
  end

  @doc """
  For each element in the next row calculate min or max sum/path using sum/path from the coresponding
  element(s) in the current row.
  """

  # calc_row for the first element in a row (only the first element of the current row can be used)
  defp calc_row(current = [a | _], next = [c | t], opt) do
    [triangle_compare(a, c, opt)] ++ calc_row_internal(current, t, opt)
  end

  # calc_row for intermediate elements in a row (either `left` or `rigth` eleme from the current row can be used)
  defp calc_row_internal([a | t1 = [b | _]], [c | t2], opt) do
    [triangle_compare(a, b, c, opt)] ++ calc_row_internal(t1, t2, opt)
  end

  # calc_row for the last element in a row (only the last element of the current row can be used)
  defp calc_row_internal([a], [c], opt) do
    [triangle_compare(a, c, opt)]
  end

  @doc """
  Calculate sum/path for an element using element(s) from the previous row
  """

  # Compare for element with two parents (elements between first and last elements in the row)
  defp triangle_compare(a, b, c, opt) do
    case opt do
      :min -> min(a, b)
      :max -> max(a, b)
    end |> triangle_compare(c, opt)
  end

  # Compare for the first or the last element (only one parent)
  defp triangle_compare({sum, path}, c, _) do
    {sum + c, [c | path]}
  end

end