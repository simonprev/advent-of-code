defmodule Day1 do
  def part1(list), do: Day1.Part1.process(list)
  def part2(list), do: Day1.Part2.process(list, list, 0, [])
end

defmodule Day1.Part1 do
  def process(list) do
    list
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end

defmodule Day1.Part2 do
  def process(list, [number | t], acc, frequencies) do
    if acc in frequencies,
      do: acc,
      else: process(list, t, acc + String.to_integer(number), [acc | frequencies])
  end

  def process(list, _, acc, frequencies), do: process(list, list, acc, frequencies)
end

ExUnit.start()

defmodule Test do
  use ExUnit.Case

  test "part2 - 1" do
    assert Day1.part2(~w(+1 -1)) === 0
  end

  test "part2 - 2" do
    assert Day1.part2(~w(+3 +3 +4 -2 -4)) === 10
  end

  test "part2 - 3" do
    assert Day1.part2(~w(-6 +3 +8 +5 -6)) === 5
  end

  test "part2 - 4" do
    assert Day1.part2(~w(+7 +7 -2 -7 -4)) === 14
  end

  test "part1 - 1" do
    assert Day1.part1(~w(+2 -5 +10)) === 7
  end
end

input =
  "input.txt"
  |> File.stream!()
  |> Stream.map(&String.trim_trailing/1)
  |> Enum.to_list()

IO.puts("Part I")

input
|> Day1.part1()
|> IO.puts()

IO.puts("\nPart II")

input
|> Day1.part2()
|> IO.puts()
