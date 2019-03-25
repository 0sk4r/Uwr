# Lista 2

## Zadanie 1

* `(x > 0) || (x - 1 < 0)` dla x = -2^31 
* `(x & 7) != 7 || (x << 29 < 0)` Lewa spełniona tylko gdy 3 ostatnie bity 1,
* `(x * x) >= 0` gdy x*x wychodzi poza int
* `x < 0 || -x <= 0` 

## Zadanie 3

overflow `x,y >= 0 s<0 ((s^x) & (s ^ y) >> 31) & 1`

underflow `x,y <= 0 x>= 0`

## Zadanie 4

```
s = (x & 0x7F7F7F7F) + (y & 0x7F7F7F7F)

s = ((x ^ y) & 0x80808080) ^ s
```





