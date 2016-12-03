# --- Part Two ---

# Now that you've helpfully marked up their design documents, it occurs to you that triangles are specified in groups of three vertically. Each set of three numbers in a column specifies a triangle. Rows are unrelated.

# For example, given the following specification, numbers with the same hundreds digit would be part of the same triangle:

# 101 301 501
# 102 302 502
# 103 303 503
# 201 401 601
# 202 402 602
# 203 403 603
# In your puzzle input, and instead reading by columns, how many of the listed triangles are possible?

counter = 0
set = []

File.readlines('input.txt').each.with_index do |line, line_num|
  set << line.split.map(&:to_i)

  if (line_num + 1) % 3 == 0
    for i in 0..2
      if set[0][i] + set[1][i] > set[2][i] and set[1][i] + set[2][i] > set[0][i] and set[0][i] + set[2][i] > set[1][i]
        counter += 1
      end
    end
    set = []
  end
end

puts counter
