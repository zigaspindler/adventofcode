class Node
  def initialize(x, y, goal, g = 0)
    @x = x
    @y = y
    @goal = goal
    @g = g
  end

  attr_reader :x, :y, :goal

  def g_score
    @g
  end

  def to_s
    "#{@x}_#{@y}"
  end

  def to_a
    [@x, @y]
  end

  def f_score
    @f_score ||= @g + (@x - @goal[0]).abs + (@y - @goal[1]).abs
  end
end
