# --- Part Two ---

# You notice a progress bar that jumps to 50% completion. Apparently, the door isn't yet satisfied, but it did emit a star as encouragement. The instructions change:

# Now, instead of considering the next digit, it wants you to consider the digit halfway around the circular list. That is, if your list contains 10 items, only include a digit in your sum if the digit 10/2 = 5 steps forward matches it. Fortunately, your list has an even number of elements.

# For example:

# 1212 produces 6: the list contains 4 items, and all four digits match the digit 2 items ahead.
# 1221 produces 0, because every comparison is between a 1 and a 2.
# 123425 produces 4, because both 2s match each other, but no other digit has a match.
# 123123 produces 12.
# 12131415 produces 4.
# What is the solution to your new captcha?

defmodule Day01.Part02 do
  def get_solution(input) do
    input
    |> Enum.with_index
    |> Enum.filter(fn({a, i}) ->
      next =
        input
        |> length
        |> div(2)
        |> Kernel.+(i)
        |> rem(length(input))
      
      a == Enum.at(input, next)
    end)
    |> Enum.map(fn({a, _i}) ->
      String.to_integer(a)
    end)
    |> Enum.sum
    |> IO.puts
  end

  def prepare_input(input) do
    input
    |> String.trim
    |> String.graphemes
  end
end

case File.read "input.txt" do
  {:ok, input} ->
    input
    |> Day01.Part02.prepare_input
    |> Day01.Part02.get_solution
  _ -> IO.puts("Error reading the input file")
end
