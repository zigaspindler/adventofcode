class Board
  def initialize(data)
    @lines = data.split("\n").map do |line|
      line.split(' ').map(&:to_i)
    end

    @lines += @lines.inject(Array.new(5) { Array.new }) do |lines, line|
      line.each_with_index { |l, i| lines[i] << l }

      lines
    end
  end

  def remove(number)
    @lines.each { |line| line.delete(number) }
  end

  def bingo?
    @lines.any? { |line| line.empty? }
  end

  def sum_unmarked
    @lines.flatten.uniq.inject(:+)
  end
end