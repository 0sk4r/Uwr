x = [n * y |  y <-x, n<-[2,3]]


g x  = x
g _ = 2


f x = x (f x)
