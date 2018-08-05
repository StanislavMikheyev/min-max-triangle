defmodule MinMaxTriangle do

  @input [
    [7],
    [6, 3],
    [3, 8, 5],
    [11, 2, 10, 9]
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

  def main(args) do
    #{opts,_,_}= OptionParser.parse(args,switches: [file: :string],aliases: [f: :file])
    input = test_input(100)
    IO.inspect input
    IO.inspect path(input)
    # line = IO.read(:line) 
    # |> String.split(" ") 
    # |> Enum.map(&convert/1)
    # IO.inspect line
  end

  def path(input) do
    path_internal(input, 0, 0, [], nil, nil)
  end

  def path_internal([last_row], position, sum, path, best_sum, best_path) do
    value = Enum.at(last_row, position)
    new_sum = value + sum

    if (best_sum == nil) or (new_sum < best_sum) do
      #IO.inspect "> new best path"
      #IO.inspect {new_sum, [value | path]}
      {new_sum, [value | path]}
    else
      #IO.inspect "> skipping branch"
      #IO.inspect {new_sum, [value | path]}
      {best_sum, best_path}
    end
  end

  def path_internal([row | tail], position, sum, path, best_sum, best_path) do
    value = Enum.at(row, position)
    new_sum = value + sum

    if (best_sum != nil) and (new_sum > best_sum) do
      #IO.inspect "> skipping branch"
      #IO.inspect {new_sum, [value | path]}
      {best_sum, best_path}
    else
      new_path = [value | path]
      # Left
      {new_best_some, new_best_path} = path_internal(tail, position, new_sum, new_path, best_sum, best_path)
      # Right
      path_internal(tail, position + 1, new_sum, new_path, new_best_some, new_best_path)
    end
  end

  def convert(str) do
    {num, _} = Integer.parse(str)
    num
  end

  def triangle_inmemory([], [h | t], opt) do
    triangle_inmemory(h, t, opt)
  end

  def triangle_inmemory(current, [h | t], opt) do
    calc_row(current, h, opt)
    |> triangle_inmemory(t, opt)
  end

  def triangle_inmemory(current, [], _) do
    current
  end

  def calc_row(current = [h1 | _], next = [h2 | t], opt) do
    [h1 + h2] ++ calc_row_internal(current, t, opt)
  end

  def calc_row_internal([a | t1 = [b | _]], [c | t2], opt) do
    [triangle_compare(a, b, c, opt)] ++ calc_row_internal(t1, t2, opt)
  end

  def calc_row_internal([a], [b], _) do
    [a + b]
  end

  def triangle_compare(a, b, c, opt) do
    case opt do
      :min ->
        c + min(a, b)
      :max ->
        c + max(a, b)
    end
  end

end