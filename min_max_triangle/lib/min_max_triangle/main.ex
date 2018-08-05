defmodule MinMaxTriangle.Main do
  @moduledoc false

  def main(args) do
    {opts, args, _} = OptionParser.parse(
      args,
      switches: [
        file: :string
      ],
      aliases: [
        f: :file
      ]
    )
    data = args
           |> hd
           |> read_file
    mod = if Enum.member?(opts, {:max, true}) do
      :max
    else
      :min
    end
    MinMaxTriangle.calculate(data, mod)
    |> generate_printable_output(mod)
    |> IO.puts
  end

  @doc """
  Turn result of the MinMaxTriangle.calculate into more readable form. First search for the best result
  (MinMaxTriangle.calculate returns result for all bottom elements) and then turn it into a string like
  `<Minimal/Maximal> path is: <1 + 2 + 3..., eg elements from path joined by plus sign> = <Sum of all elements>.`
  """
  def generate_printable_output(result, opt) do
    {sum, trianlge_path_reversed} = case opt do
      :min -> Enum.min(result)
      :max -> Enum.max(result)
    end
    trianlge_path = Enum.reverse(trianlge_path_reversed)
    print_head = hd(trianlge_path)
                 |> Integer.to_string()
    print_tail = tl(trianlge_path)
                 |> Enum.reduce(
                      "",
                      fn
                        x, acc -> acc <> " + " <> Integer.to_string(x)
                      end
                    )
    phrase_beginning = case opt do
      :min -> "Minimal path is: "
      :max -> "Maximal path is: "
    end
    phrase_beginning <> print_head <> print_tail <> " = " <> Integer.to_string(sum)
  end

  @doc """
  Read triangle from file
  """
  def read_file(path) do
    File.open!(path, [:read], fn stream -> read_until_eof(stream) end)
  end

  defp read_until_eof(stream) do
    case IO.read(stream, :line) do
      :eof ->
        []
      data ->
        [
          String.split(data, " ")
          |> Enum.map(&convert/1) | read_until_eof(stream)
        ]
    end
  end

  defp convert(str) do
    {num, _} = Integer.parse(str)
    num
  end

end
