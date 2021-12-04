# --- Part Two ---
# On the other hand, it might be wise to try a different strategy: let the giant squid win.

# You aren't sure how many bingo boards a giant squid could play at once, so rather than waste time counting its arms, the safe thing to do is to figure out which board will win last and choose that one. That way, no matter which boards it picks, it will win for sure.

# In the above example, the second board is the last to win, which happens after 13 is eventually called and its middle column is completely marked. If you were to keep playing until this point, the second board would have a sum of unmarked numbers equal to 148 for a final score of 148 * 13 = 1924.

# Figure out which board will win last. Once it wins, what would its final score be?

require './board.rb'

draw, *boards = File.read("input.txt").split("\n\n")

draw = draw.split(',').map(&:to_i)

boards = boards.map{ |board| Board.new(board) }

draw.each do |number|
  boards.delete_if do |board|
    board.remove(number)

    if board.bingo?
      if boards.size == 1
        p board.sum_unmarked * number
        return
      end
    end

    board.bingo?
  end
end