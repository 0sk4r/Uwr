----------------------------
-- Oskar Sobczyk
----------------------------

-- Wymagamy, by moduł zawierał tylko bezpieczne funkcje
{-# LANGUAGE Safe #-}
-- Definiujemy moduł zawierający rozwiązanie.
-- Należy zmienić nazwę modułu na {Imie}{Nazwisko} gdzie za {Imie}
-- i {Nazwisko} należy podstawić odpowiednio swoje imię i nazwisko
-- zaczynające się wielką literą oraz bez znaków diakrytycznych.
module OskarSobczyk (typecheck, eval) where

-- Importujemy moduły z definicją języka oraz typami potrzebnymi w zadaniu
import AST
import DataTypes
import Data.List

-- Funkcja sprawdzająca typy
-- Dla wywołania typecheck vars e zakładamy, że zmienne występujące
-- w vars są już zdefiniowane i mają typ int, i oczekujemy by wyrażenia e
-- miało typ int
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.


--sprawdza czy element jest w liscie
inList ::  Eq(a) => a -> [a] -> Bool 
inList x xs = x `elem` xs 


--Inicjuje środowisko
initList :: [Var] -> [TypeEnv]
initList lst = [ (x,TInt) | x <- lst ]

type TypeEnv = (String,MType)

data MType = TBool | TInt deriving(Show,Eq)

data Error p = ErrorType p String deriving Show

typecheck :: [Var] -> Expr p -> TypeCheckResult p

typecheck vars expr = 
	--initlist inicjuje liste [(var,TInt)]
	case checker (initList vars) expr of
		Right TInt -> Ok
		Left (ErrorType p err) -> Error p err
		otherwise -> Error  (getData expr) "program not return int"



--Funkcja sprawdzajaca typy przyjmuje SRODOWISKO oraz WYRAZENIE zwraca typ wyrzaenia lub blad
--Istnieje mozliwosc zwiniecia tych funkcji ale dla mnie wydaja sie one mniej czytelne 

checker :: [TypeEnv] -> Expr p -> Either (Error p) MType

checker types (ENum p var) = Right TInt

checker types (EBool p var) = Right TBool

checker types (EVar p var) = case getVariable var types of
	Just x -> Right x
	otherwise -> Left (ErrorType p ("undefined var: " ++ var))

checker types (EUnary p op expr) =
	case op of
		UNeg -> case checker types expr of 
			Right TInt -> Right TInt
			otherwise -> Left (ErrorType p "-bool (expected int)")
		UNot -> case checker types expr of 
			Right TBool -> Right TBool 
			otherwise -> Left (ErrorType p "~int (expected bool)")

checker types (EBinary p BAdd expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left err -> Left err
			otherwise -> Left (ErrorType p "... + bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) + ...")

checker types (EBinary p BSub expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left err -> Left err
			otherwise -> Left (ErrorType p "... - bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) - ...")


checker types (EBinary p BMod expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left err -> Left err
			otherwise -> Left (ErrorType p "... mod bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) mod ...")


checker types (EBinary p BMul expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left err -> Left err
			otherwise -> Left (ErrorType p "... * bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) * ...")



checker types (EBinary p BDiv expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left err -> Left err
			otherwise -> Left (ErrorType p "... div bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) div ...")



checker types (EBinary p BGt expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left err -> Left err
			otherwise -> Left (ErrorType p "... > bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) < ...")


checker types (EBinary p BGe expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left err -> Left err
			otherwise -> Left (ErrorType p "... => bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) <= ...")


checker types (EBinary p BLt expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left err -> Left err
			otherwise -> Left (ErrorType p "... < bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) < ...")


checker types (EBinary p BLe expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left err -> Left err
			otherwise -> Left (ErrorType p "... <= bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) <= ...")


checker types (EBinary p BEq expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left err -> Left err
			otherwise -> Left (ErrorType p "... = bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) = ...")

checker types (EBinary p BNeq expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left err -> Left err
			otherwise -> Left (ErrorType p "... <> bool (expected int)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "bool (expected int) <> ...")



checker types (EBinary p BAnd expr1 expr2) = 
	case checker types expr1 of
		Right TBool -> case checker types expr2 of
			Right TBool -> Right TBool
			Left err -> Left err
			otherwise -> Left (ErrorType p "... and int (expected bool)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "int (expected bool) and ...")

checker types (EBinary p BOr expr1 expr2) = 
	case checker types expr1 of
		Right TBool -> case checker types expr2 of
			Right TBool -> Right TBool
			Left err -> Left err
			otherwise -> Left (ErrorType p "... or int (expected bool)")
		Left err -> Left err
		otherwise -> Left (ErrorType p "int (expected bool) or ...")

checker types (EIf p exbool expr1 expr2) =
	case checker types exbool of
		Right TBool -> case checker types expr1 of
			Right TInt -> case checker types expr2 of
				Right TInt -> Right TInt
				Left err -> Left err
				otherwise -> Left (ErrorType p "int and bool (expected int) in if")
			Left err -> Left err
			Right TBool -> case checker types expr2 of
				Right TBool -> Right TBool
				Left err -> Left err
				otherwise -> Left (ErrorType p "bool and int (expected bool) in if")
		Left err -> Left err
		otherwise -> Left (ErrorType p "if (no bool expr) then ...")



--kiedy let nadpisuje jakas zmienna dodajemy ja na koniec listy a kiedy bedziemy chcieli z niej skorzystac to zawsze bierzemy 
--najswiezsza zmienna (z konca listy)
checker types (ELet p var expr1 expr2) = 
	case checker types expr1 of
		Right TBool -> case checker (types ++ [(var,TBool)]) expr2 of
			Right TBool -> Right TBool
			Right TInt -> Right TInt
			Left err -> Left err
		Right TInt -> case checker (types ++ [(var,TInt)]) expr2 of
			Right TBool -> Right TBool
			Right TInt -> Right TInt
			Left err -> Left err
		Left err -> Left err




			

-- Funkcja obliczająca wyrażenia
-- Dla wywołania eval input e przyjmujemy, że dla każdej pary (x, v)
-- znajdującej się w input, wartość zmiennej x wynosi v.
-- Możemy założyć, że wyrażenie e jest dobrze typowane, tzn.
-- typecheck (map fst input) e = Ok
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.


--operacje na srodowisku:
--lookup zwraca typ albo ze nie ma typu
--extend srodowisko typ zwraca nowe srodowisko
--empty puste srodowisko
--

--zwraca dla x zwraca z tablicy par [(x,y)] y, zwraca najswiezsza zmienna (bierze pierwsza zmienna od konca tablicy)
getVariable :: (Eq a) => a -> [(a,b)] -> Maybe b 

getVariable var zmienne = lookup var (reverse zmienne)

eval :: [(Var,Integer)] -> Expr p -> EvalResult
eval var expr = case evalExpr var [] expr of
	Right val -> Value val
	Left err -> RuntimeError
	
--evalExpr przyjmuje tablice wartosci int [(Var, wartosc int)] oraz tablice wartosci boolowskich [(Var, wartosc bool)] 
--zwraca Integer lub string. Strign bedzie reprezentowac wartosci boolowskie "true"/"false" lub error 
evalExpr :: [(Var,Integer)] -> [(Var,String)] -> Expr p -> Either String Integer

evalExpr varint varbool (ENum p var) = Right var

evalExpr varint varbool (EBool p var) =
	case var of
		True -> Left "true"
		False -> Left "false"

evalExpr varint varbool (EVar p var) = case getVariable var varbool of
	Just x -> Left x
	otherwise -> case getVariable var varint of
		Just x -> Right x
		otherwise -> Left "var undefined"

-----------------------
--Operatory unarne
-----------------------


evalExpr varint varbool (EUnary p UNeg expr) =
	case evalExpr varint varbool expr of
		Right val -> Right (-val)
		Left err -> Left err

evalExpr varint varbool (EUnary p UNot expr) =
	case evalExpr varint varbool expr of
		Left "true" -> Left "false"
		Left "false" -> Left "true"
		Left err -> Left err


-----------------------
--Operatory arytmetyczne
-----------------------

evalExpr varint varbool (EBinary p BAdd expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> Right (val1 + val2)
			Left err -> Left err
		Left err -> Left err

evalExpr varint varbool (EBinary p BSub expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> Right (val1 - val2)
			Left err -> Left err
		Left err -> Left err

evalExpr varint varbool (EBinary p BMul expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> Right (val1 * val2)
			Left err -> Left err
		Left err -> Left err

evalExpr varint varbool (EBinary p BDiv expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right 0 -> Left "div by 0"
			Right val2 -> Right (val1 `div` val2)
			Left err -> Left err
		Left err -> Left err

evalExpr varint varbool (EBinary p BMod expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right 0 -> Left "mod by 0"
			Right val2 -> Right (val1 `mod` val2)
			Left err -> Left err
		Left err -> Left err


-----------------------
--Operatory logiczne
-----------------------
evalExpr varint varbool (EBinary p BAnd expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Left "true" -> case evalExpr varint varbool expr2 of
			Left "true" -> Left "true"
			Left "false" -> Left "false"
			Left err -> Left err
		Left "false" -> case evalExpr varint varbool expr2 of
			Left "true" -> Left "false"
			Left "false" -> Left "false"
			Left err -> Left err

evalExpr varint varbool (EBinary p BOr expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Left "true" -> case evalExpr varint varbool expr2 of
			Left "true" -> Left "true"
			Left "false" -> Left "true"
			Left err -> Left err
		Left "false" -> case evalExpr varint varbool expr2 of
			Left "true" -> Left "true"
			Left "false" -> Left "false"
			Left err -> Left err


-----------------------
--Operatory porownania
-----------------------

evalExpr varint varbool (EBinary p BLt expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> if val1 < val2 then Left "true" else Left "false"
			Left err -> Left err
		Left err -> Left err

evalExpr varint varbool (EBinary p BLe expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> if val1 <= val2 then Left "true" else Left "false"
			Left err -> Left err
		Left err -> Left err

evalExpr varint varbool (EBinary p BGt expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> if val1 > val2 then Left "true" else Left "false"
			Left err -> Left err
		Left err -> Left err

evalExpr varint varbool (EBinary p BGe expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> if val1 >= val2 then Left "true" else Left "false"
			Left err -> Left err
		Left err -> Left err


evalExpr varint varbool (EBinary p BEq expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> if val1 == val2 then Left "true" else Left "false"
			Left err -> Left err
		Left err -> Left err

evalExpr varint varbool (EBinary p BNeq expr1 expr2) =
	case evalExpr varint varbool expr1 of
		Right val1 -> case evalExpr varint varbool expr2 of
			Right val2 -> if val1 /= val2 then Left "true" else Left "false"
			Left err -> Left err
		Left err -> Left err

-----------------------
--If
-----------------------

evalExpr varint varbool (EIf p exprbool expr1 expr2) =
	case evalExpr varint varbool exprbool of
		Left "true" -> case evalExpr varint varbool expr1 of
			Right val -> Right val
			Left err -> Left err
		Left "false" -> case evalExpr varint varbool expr2 of
			Right val -> Right val
			Left err -> Left err
		Left err -> Left err

-----------------------
--Let
-----------------------

evalExpr varint varbool (ELet p var expr1 expr2) =
	case evalExpr varint varbool expr1 of
		--Let w ktorym nadpisywana jest jakas wczesza zmienna bedzie dzialac poniewaz kiedy program dochodzi do EVar 
		--najpierw przesukuje od konca tablicee wartosci boolowskich a dopieto potem int
		Left "true" -> case evalExpr varint (varbool ++ [(var,"true")]) expr2 of
			Right val -> Right val
			Left err -> Left err
		Left "false" -> case evalExpr varint (varbool ++ [(var,"false")]) expr2 of
			Right val -> Right val
			Left err -> Left err
		--Jezeli zmienna ktora nadpisujemy ma miec wartosc int to mozemy usunac wystapienia tej zmiennej z tablicy bool poniewaz w przyslosci
		--i tak nie wykorzystamy tych wartosci. Delete dziala w taki sposob ze jesli usuwanego elementu nie ma w tablicy to zwroci nie zmieniona tablice.
		--Czyli mozemy bezpiecznie usuwac "nie istniejace" wpisy w tablicy bool
		Right val -> case evalExpr (varint ++ [(var,val)]) (delete (var,"true") (delete (var,"false") varbool)) expr2 of
			Right val -> Right val
			Left err -> Left err
		Left err -> Left err