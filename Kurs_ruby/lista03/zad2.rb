def pierwsze(n)
  (2..n).select {|x| (2..Math.sqrt(x)).none? {|d| x%d == 0}}
end

def doskonale(n)
  (2..n).select {|x| x == (1...x).select {|y| x % y == 0}.inject(:+)}
end

print pierwsze(100)
puts
print doskonale(1000)
