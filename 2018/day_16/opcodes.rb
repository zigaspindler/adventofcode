OPCODES = %i[addr addi mulr muli banr bani borr bori setr seti
             gtir gtri gtrr eqir eqri eqrr]

def addr(register, command)
  _, a, b, c = command
  register[c] = register[a] + register[b]
  register
end

def addi(register, command)
  _, a, b, c = command
  register[c] = register[a] + b
  register
end

def mulr(register, command)
  _, a, b, c = command
  register[c] = register[a] * register[b]
  register
end

def muli(register, command)
  _, a, b, c = command
  register[c] = register[a] * b
  register
end

def banr(register, command)
  _, a, b, c = command
  register[c] = register[a] & register[b]
  register
end

def bani(register, command)
  _, a, b, c = command
  register[c] = register[a] & b
  register
end

def borr(register, command)
  _, a, b, c = command
  register[c] = register[a] | register[b]
  register
end

def bori(register, command)
  _, a, b, c = command
  register[c] = register[a] | b
  register
end

def setr(register, command)
  _, a, _, c = command
  register[c] = register[a]
  register
end

def seti(register, command)
  _, a, _, c = command
  register[c] = a
  register
end

def gtir(register, command)
  _, a, b, c = command
  register[c] = a > register[b] ? 1 : 0
  register
end

def gtri(register, command)
  _, a, b, c = command
  register[c] = register[a] > b ? 1 : 0
  register
end

def gtrr(register, command)
  _, a, b, c = command
  register[c] = register[a] > register[b] ? 1 : 0
  register
end

def eqir(register, command)
  _, a, b, c = command
  register[c] = a == register[b] ? 1 : 0
  register
end

def eqri(register, command)
  _, a, b, c = command
  register[c] = register[a] == b ? 1 : 0
  register
end

def eqrr(register, command)
  _, a, b, c = command
  register[c] = register[a] == register[b] ? 1 : 0
  register
end
