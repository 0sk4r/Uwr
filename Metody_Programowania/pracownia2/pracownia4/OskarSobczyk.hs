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

initList :: [Var] -> [TypeEnv]
initList lst = [ (x,TInt) | x <- lst ]

type TypeEnv = (String,MType)

data MType = TBool | TInt deriving(Show,Eq)

data Error p = ErrorType p String deriving Show

typecheck :: [Var] -> Expr p -> TypeCheckResult p

typecheck vars expr = 
	case checker (initList vars) expr of
		Right TInt -> Ok
		Left (ErrorType p blad) -> Error p blad
		otherwise -> Error  (getData expr) "program not return int"


checker :: [TypeEnv] -> Expr p -> Either (Error p) MType

checker types (ENum p var) = Right TInt

checker types (EVar p var) = case getVariable var types of
	Just x -> Right x
	otherwise -> Left (ErrorType p ("undefined var: " ++ var))

checker types (EBool p var) = Right TBool

checker types (EUnary p op expr) =
	case op of
		UNeg -> case checker types expr of 
			Right TInt -> Right TInt
			otherwise -> Left (ErrorType p "-bool")
		UNot -> case checker types expr of 
			Right TBool -> Right TBool 
			otherwise -> Left (ErrorType p "~int")

checker types (EBinary p BAdd expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "bool + ...")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "... + bool")

checker types (EBinary p BSub expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "bool - ...")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "... - bool")


checker types (EBinary p BMod expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "bool mod ...")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "... mod bool")


checker types (EBinary p BMul expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "bool * ...")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p ".. * bool")



checker types (EBinary p BDiv expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TInt
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "bool div ...")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "... div bool")



checker types (EBinary p BGt expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "int > bool")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "bool < ...")


checker types (EBinary p BGe expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "... => bool")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "bool <= ...")


checker types (EBinary p BLt expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "... < bool")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "bool < ...")


checker types (EBinary p BLe expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "... <= bool")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "bool <= ...")


checker types (EBinary p BEq expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "... = bool")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "bool = ...")

checker types (EBinary p BNeq expr1 expr2) = 
	case checker types expr1 of
		Right TInt -> case checker types expr2 of
			Right TInt -> Right TBool
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "... <> bool")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "bool <> ...")



checker types (EBinary p BAnd expr1 expr2) = 
	case checker types expr1 of
		Right TBool -> case checker types expr2 of
			Right TBool -> Right TBool
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "... and int")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "int and ...")

checker types (EBinary p BOr expr1 expr2) = 
	case checker types expr1 of
		Right TBool -> case checker types expr2 of
			Right TBool -> Right TBool
			Left blad -> Left blad
			otherwise -> Left (ErrorType p "... or int")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "int or ...")

checker types (EIf p exbool expr1 expr2) =
	case checker types exbool of
		Right TBool -> case checker types expr1 of
			Right TInt -> case checker types expr2 of
				Right TInt -> Right TInt
				Left blad -> Left blad
				otherwise -> Left (ErrorType p "int and bool in if")
			Left blad -> Left blad
			Right TBool -> case checker types expr2 of
				Right TBool -> Right TBool
				Left blad -> Left blad
				otherwise -> Left (ErrorType p "bool and int in if")
		Left blad -> Left blad
		otherwise -> Left (ErrorType p "no bool expr in bool expr")


checker types (ELet p var expr1 expr2) = 
	case checker types expr1 of
		Right TBool -> case checker (types ++ [(var,TBool)]) expr2 of
			Right TBool -> Right TBool
			Right TInt -> Right TBool
			Left blad -> Left blad
		Right TInt -> case checker (types ++ [(var,TInt)]) expr2 of
			Right TBool -> Right TBool
			Right TInt -> Right TInt
			Left blad -> Left blad
			

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

data RError p = ErrorRun p String deriving Show


getVariable :: (Eq a) => a -> [(a,b)] -> Maybe b 

getVariable var zmienne = lookup var (reverse zmienne)

eval :: [(Var,Integer)] -> Expr p -> EvalResult
eval kupa kupad = RuntimeError	

--eval zmienne (EIf p bexpr expr1 expr2) =
--	if evalBExpr zmienne bexpr
--		then evalExpr zmienne expr1
--		else evalExpr zmienne expr2

data EType = Integer | Bool deriving(Show,Eq)

type Mint = Integer
type Mbool = Bool


evalExpr :: [(Var,Integer)] -> [(Var,String)] -> Expr p -> Either String Integer

evalExpr zmienneint zmiennebool (ENum p var) = Right var

evalExpr zmienneint zmiennebool (EBool p var) =
	case var of
		True -> Left "true"
		False -> Left "false"

evalExpr zmienneint zmiennebool (EVar p var) = case getVariable var zmiennebool of
	Just x -> Left x
	otherwise -> case getVariable var zmienneint of
		Just x -> Right x
		otherwise -> Left "var undefined"

evalExpr zmienneint zmiennebool (EUnary p UNeg expr) =
	case evalExpr zmienneint zmiennebool expr of
		Right val -> Right (-val)
		Left blad -> Left blad

evalExpr zmienneint zmiennebool (EUnary p UNot expr) =
	case evalExpr zmienneint zmiennebool expr of
		Left "true" -> Left "false"
		Left "false" -> Left "true"
		Left blad -> Left blad

evalExpr zmienneint zmiennebool (EBinary p BAdd expr1 expr2) =
	case evalExpr zmienneint zmiennebool expr1 of
		Right val1 -> case evalExpr zmienneint zmiennebool expr2 of
			Right val2 -> Right (val1 + val2)
			Left blad -> Left blad
		Left blad -> Left blad

evalExpr zmienneint zmiennebool (EBinary p BSub expr1 expr2) =
	case evalExpr zmienneint zmiennebool expr1 of
		Right val1 -> case evalExpr zmienneint zmiennebool expr2 of
			Right val2 -> Right (val1 - val2)
			Left blad -> Left blad
		Left blad -> Left blad

evalExpr zmienneint zmiennebool (EBinary p BMul expr1 expr2) =
	case evalExpr zmienneint zmiennebool expr1 of
		Right val1 -> case evalExpr zmienneint zmiennebool expr2 of
			Right val2 -> Right (val1 * val2)
			Left blad -> Left blad
		Left blad -> Left blad

evalExpr zmienneint zmiennebool (EBinary p BDiv expr1 expr2) =
	case evalExpr zmienneint zmiennebool expr1 of
		Right val1 -> case evalExpr zmienneint zmiennebool expr2 of
			Right val2 -> Right (val1 + val2)
			Left blad -> Left blad
		Left blad -> Left blad

{-|

evalExpr zmienne (EUnary p UNeg expr) = 
	case evalExpr zmienne expr of
		Right val -> Right val
		Left blad -> Left blad


evalExpr zmienne (EUnary p  UNeg expr) = (- evalExpr zmienne expr)

evalExpr zmienne (EBinary p op expr1 expr2) =
	case op of
		BAdd -> evalExpr zmienne expr1 + evalExpr zmienne expr2
		BMul -> evalExpr zmienne expr1 * evalExpr zmienne expr2
		BSub -> evalExpr zmienne expr1 - evalExpr zmienne expr2
		BDiv -> evalExpr zmienne expr1 `div` (let x = evalExpr zmienne expr2 in if x == 0 then error $ "div by 0" else x)
		BMod -> evalExpr zmienne expr1 `mod` (let x = evalExpr zmienne expr2 in if x == 0 then error $ "mod by 0" else x)

evalExpr zmienne (EIf p bexpr expr1 expr2) =
	if evalBExpr zmienne bexpr
		then evalExpr zmienne expr1
		else evalExpr zmienne expr2


--evalExpr zmienne (ELet p var expr1 expr2) =
--	evalExpr (zmienne ++ [(var,evalExpr zmienne expr1)]) expr2

evalBExpr :: [(Var,Integer)] -> Expr p -> Bool

evalBExpr zmienne (EBool p var) = var

evalBExpr zmienne (EUnary p UNot expr) = not (evalBExpr zmienne expr)

evalBExpr zmienne (EBinary p op expr1 expr2) =
	case op of
		BEq -> evalExpr zmienne expr1 == evalExpr zmienne expr2
		BNeq -> evalExpr zmienne expr1 /= evalExpr zmienne expr2
		BGe -> evalExpr zmienne expr1 >= evalExpr zmienne expr2
		BGt -> evalExpr zmienne expr1 > evalExpr zmienne expr2
		BLe -> evalExpr zmienne expr1 <= evalExpr zmienne expr2
		BLt -> evalExpr zmienne expr1 < evalExpr zmienne expr2
		BOr -> evalBExpr zmienne expr1 || evalBExpr zmienne expr2
		BAnd -> evalBExpr zmienne expr1 && evalBExpr zmienne expr2
		-}