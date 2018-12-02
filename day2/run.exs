defmodule Day2 do
  def part1(list), do: Day2.Part1.process(list)
  def part2(list), do: Day2.Part2.process(list)
end

defmodule Day2.Part1 do
  def process(list) do
    Enum.map(list, fn item ->
      item
      |> String.split("")
      |> Enum.filter(&(&1 !== ""))
      |> Enum.reduce(%{}, fn letter, acc -> update_in(acc, [letter], &((&1 || 0) + 1)) end)
      |> Enum.filter(&(elem(&1, 1) in [2, 3]))
      |> Enum.uniq_by(&elem(&1, 1))
    end)
    |> Enum.reduce({0, 0}, fn
      [{_, 2}], {two, three} -> {two + 1, three}
      [{_, 3}], {two, three} -> {two, three + 1}
      [{_, 3}, {_, 2}], {two, three} -> {two + 1, three + 1}
      [{_, 2}, {_, 3}], {two, three} -> {two + 1, three + 1}
      _, acc -> acc
    end)
    |> (&(elem(&1, 0) * elem(&1, 1))).()
  end
end

defmodule Day2.Part2 do
  def process(list) do
    list
    |> Enum.reduce_while(nil, fn item, _ ->
      Enum.reduce_while(list, nil, fn other_item, _ ->
        similar =
          item
          |> String.split("")
          |> Enum.filter(&(&1 !== ""))
          |> Enum.with_index()
          |> Enum.reject(fn {letter, index} -> String.at(other_item, index) !== letter end)
          |> Enum.map(&elem(&1, 0))
          |> Enum.join("")

        if String.length(item) - 1 !== String.length(similar) do
          {:cont, nil}
        else
          {:halt, similar}
        end
      end)
      |> case do
        nil -> {:cont, nil}
        similar -> {:halt, similar}
      end
    end)
  end
end

ExUnit.start()

defmodule Test do
  use ExUnit.Case

  test "part1" do
    assert Day2.part1(~w(
      abcdef
      bababc
      abbcde
      abcccd
      aabcdd
      abcdee
      ababab
    )) === 12
  end

  test "part2" do
    assert Day2.part2(~w(
      abcde
      fghij
      klmno
      pqrst
      fguij
      axcye
      wvxyz
    )) === "fgij"
  end
end

input =
  "input.txt"
  |> File.stream!()
  |> Stream.map(&String.trim_trailing/1)
  |> Enum.to_list()

IO.puts("Part I")

input
|> Day2.part1()
|> IO.puts()

IO.puts("Part II")

input
|> Day2.part2()
|> IO.puts()
