# --- Part Two ---

# Now, take the signal you got on wire a, override wire b to that signal, and reset the other wires (including wire a). What new signal is ultimately provided to wire a?

class Wires
  OPERATORS = {
    'AND' => '&',
    'OR' => '|',
    'RSHIFT' => '>>',
    'LSHIFT' => '<<',
    'NOT' => '~',
    # some identifiers are reserved words
    'if' => '_if',
    'do' => '_do',
    'in' => '_in'
  }

  def add(line)
    OPERATORS.each do |k, v|
      line.gsub! k, v
    end
    command, target = line.split ' -> '

    method = "def #{target}; @#{target} ||= #{command}; end"

    instance_eval method
  end
end

wires = Wires.new

File.open('input.txt', 'r') do |input|
  while (line = input.gets)
    wires.add line.chomp
  end
end

wires.add '956 -> b' # part one solution

puts wires.a
