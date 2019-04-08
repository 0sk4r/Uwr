-- Zadania egzamin haskell
multiply :: (Integer,Integer) -> Integer
multiply (x, y) =  if x==0 then 0 else x * y

infinity :: Integer
infinity = infinity + 1

newtype Number = Number Integer

nonzero (Number 0) = False
nonzero _ = True

data T = T (Bool, Bool)
newtype S = S (Bool, Bool)

data Czlowiek = Syn Czlowiek Czlowiek | Jan | Ewa
Jan = (Syn Jan Ewa)

newtype ToSamo a = ToSamo a
data Cos a = Cos a

times :: Integer -> Integer -> Integer
0 `times` _ = 0
n `times` m = n * m

xs :: [Integer]
xs = 1 : map (2*) xs

f :: Integer -> Integer
f n = n * ( f $ n - 1)
f 0 = 1

f21 x = x (f21 x)

f26 [] = []
f26 (x:xs) = x : aux xs where aux = aux

f1 x = map x "abc"

--f2 x = map x x

f3 x = x*x

data Tree a = Node a [Tree a]

inftree :: Tree Integer
inftree = head ts where 
    ts = map(\(Node n rs) -> Node (n+1) (tail rs)) (Node 0 ts:ts)

firstSons, sonsOfRoot :: Tree a -> [a]
firstSons (Node x xs) = x : firstSons (head xs)
sonsOfRoot (Node x xs) = map (\(Node y _) -> y) xs

zeros :: [Integer]
zeros = 0:zeros
