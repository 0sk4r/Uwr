newtype Number = Number Integer
nonzero (Number 0) = False
nonzero _ = True

data T = T(Bool,Bool)
newtype S = S (Bool,Bool)

f x = x (f x)
