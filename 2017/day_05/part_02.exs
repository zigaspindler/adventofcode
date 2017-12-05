# --- Part Two ---

# Now, the jumps are even stranger: after each jump, if the offset was three or more, instead decrease it by 1. Otherwise, increase it by 1 as before.

# Using this rule with the above example, the process now takes 10 steps, and the offset values after finding the exit are left as 2 3 2 3 -1.

# How many steps does it now take to reach the exit?

defmodule Day05.Part02 do
  def run(instructions) do
    get_steps(instructions, 1, 0)
  end

  defp get_steps(instructions, step, position) when position >= 0 and position < map_size(instructions) do
    jump = instructions[position]
    change = if jump < 3, do: 1, else: -1

    put_in(instructions[position], jump + change)
    |> get_steps(step + 1, position + jump)
  end
  defp get_steps(_, step, _), do: step - 1
end

File.stream!("input.txt")
|> Stream.map(&String.trim/1)
|> Enum.map(&String.to_integer/1)
|> Enum.with_index
|> Enum.map(fn {k,v} -> {v,k} end) 
|> Map.new
|> Day05.Part02.run
|> IO.puts
