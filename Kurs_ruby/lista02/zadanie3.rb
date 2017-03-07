def suma(graf1, graf2)
  wynik = graf1.merge(graf2) do |key, value1, value2|
    value1 + value2
  end
end

def suma!(graf1, graf2)
  graf1.merge!(graf2) do |key, value1, value2|
    value1 + value2
  end
end

graf1 = {"a" => ["b", "c"], 'd' => ["e", "f"]}
graf2 = {"c" => ["q", "t", "f"], "e" => ["a", "c"]}
graf3 = {"a" => ["d", "e"], "g" => ["l"]}

puts suma(graf1, graf2)
puts suma(graf1, graf3)

puts suma!(graf1, graf2)
puts graf1
puts suma!(graf1, graf3)
