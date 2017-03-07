from math import log

a = log(6.0/5.0)
print(a)
for n in range (1,25):
	a = (1.0/n) - 5*a
	print(a)