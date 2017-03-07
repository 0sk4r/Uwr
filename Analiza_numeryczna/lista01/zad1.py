x0 = 1.0
x1 = 1.0/7.0
print(x0)
print(x1)
print("%%%%%%%%%%%")

for i in range(20):
	x = (-(34.0/7.0))*x1 + (5.0/7.0)*x0
	x0 = x1
	x1 = x
	print (x1)
