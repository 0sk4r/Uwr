from math import log, exp

iter = 30

def myLog(x):
	sum = 0.0
	if(x < 1.0):
		for k in range(1,iter):
			sum += ((-1.0)**(k-1.0)) * (((x-1.0)**k)/k)
		return sum
	return (1.0 + myLog(x/exp(1.0)))


print (myLog(0.5))
print (log(0.5))


for x in range(1000000,110000000,1000000):
	print(myLog(x))
	print(log(x))