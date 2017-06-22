data Czlowiek = Syn Czlowiek Czlowiek | Jan | Ewa

data Board coord = Board coord coord

newtype MyMon a = MyMon (a Integer)
instance Monad MyMon  where
    return x = MyMon x 0
    MyMon x r >>= f = MyMon y (r+s) where MyMon y s = f x

newtype S = S S
