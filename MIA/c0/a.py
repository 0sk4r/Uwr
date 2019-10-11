import math
for _ in range(int(input())):
    n = int(input())
    prices_list = map(int, input().split(" "))
    print(math.ceil(sum(prices_list)/n))