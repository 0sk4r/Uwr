def pascal(n)
  p=[1]
  while p.length<=n
    puts p.join(' ')
    p=Array.new(p.length+1) do |i|
      a=if i<p.length
          p[i]
        else
          0
        end
      b=if i>0
          p[i-1]
        else
          0
        end
      a+b
    end
  end
end

puts pascal(10)

def rozklad(n)
  if n == 1
    return [1]
  end
  czynnik = 2
  temp = []
  while czynnik <= n
    if n % czynnik == 0
      if not temp.member?(czynnik)
        temp.push(czynnik)
      end
      n /= czynnik
    else
      czynnik += 1
    end
  end
  temp
end

print rozklad(1026)
print rozklad(121)