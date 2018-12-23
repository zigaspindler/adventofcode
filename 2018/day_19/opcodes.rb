def addr(register, a, b, c)
  register[c] = register[a] + register[b]
  register
end

def addi(register, a, b, c)
  register[c] = register[a] + b
  register
end

def mulr(register, a, b, c)
  register[c] = register[a] * register[b]
  register
end

def muli(register, a, b, c)
  register[c] = register[a] * b
  register
end

def banr(register, a, b, c)
  register[c] = register[a] & register[b]
  register
end

def bani(register, a, b, c)
  register[c] = register[a] & b
  register
end

def borr(register, a, b, c)
  register[c] = register[a] | register[b]
  register
end

def bori(register, a, b, c)
  register[c] = register[a] | b
  register
end

def setr(register, a, b, c)
  register[c] = register[a]
  register
end

def seti(register, a, b, c)
  register[c] = a
  register
end

def gtir(register, a, b, c)
  register[c] = a > register[b] ? 1 : 0
  register
end

def gtri(register, a, b, c)
  register[c] = register[a] > b ? 1 : 0
  register
end

def gtrr(register, a, b, c)
  register[c] = register[a] > register[b] ? 1 : 0
  register
end

def eqir(register, a, b, c)
  register[c] = a == register[b] ? 1 : 0
  register
end

def eqri(register, a, b, c)
  register[c] = register[a] == b ? 1 : 0
  register
end

def eqrr(register, a, b, c)
  register[c] = register[a] == register[b] ? 1 : 0
  register
end
