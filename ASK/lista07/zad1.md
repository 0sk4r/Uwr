#Zadanie 1

```
>> readelf -s zad1.o

Symbol table '.symtab' contains 14 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS zad1.c
     2: 0000000000000000     0 SECTION LOCAL  DEFAULT    1
     3: 0000000000000000     0 SECTION LOCAL  DEFAULT    3
     4: 0000000000000000     0 SECTION LOCAL  DEFAULT    5
     5: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    5 bufp1
     6: 0000000000000000    22 FUNC    LOCAL  DEFAULT    1 incr
     7: 0000000000000008     4 OBJECT  LOCAL  DEFAULT    5 count.1835
     8: 0000000000000000     0 SECTION LOCAL  DEFAULT    7
     9: 0000000000000000     0 SECTION LOCAL  DEFAULT    8
    10: 0000000000000000     0 SECTION LOCAL  DEFAULT    6
    11: 0000000000000000     8 OBJECT  GLOBAL DEFAULT    3 bufp0
    12: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND buf
    13: 0000000000000016    74 FUNC    GLOBAL DEFAULT    1 swap
```


#Zadanie 5
```
1. >> ar -t /usr/lib/x86_64-linux-gnu/libc.a | wc -l
   1579

   >> ar -t /usr/lib/x86_64-linux-gnu/libm.a | wc -l
   471 

2. >> objdump -dx prog1 >> dump1
   >> objdump -dx prog2 >> dump2
   >> diff dump1 dump2

3. readelf -d /usr/bin/python3 | grep 'Shared library'

    0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
    0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
    0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
    0x0000000000000001 (NEEDED)             Shared library: [libutil.so.1]
    0x0000000000000001 (NEEDED)             Shared library: [libexpat.so.1]
    0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
    0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
```

#Zadanie 7

```
    >> c++filt -n _Z4funcPKcRi
    func(char const*, int&)

    >> c++filt -n _ZN3Bar3bazEPc
    Bar::baz(char*)

    >> c++filt -n _ZN3BarC1ERKS_
    Bar::Bar(Bar const&)

    >> c++filt -n _ZN3foo6strlenER6string
    foo::strlen(string&)
```
