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
import qualified Data.Map as M

-- Funkcja sprawdzająca typy
-- Dla wywołania typecheck vars e zakładamy, że zmienne występujące
-- w vars są już zdefiniowane i mają typ int, i oczekujemy by wyrażenia e
-- miało typ int
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.
typecheck :: [Var] -> Expr p -> TypeCheckResult p
typecheck vars expr = Ok

-- Funkcja obliczająca wyrażenia
-- Dla wywołania eval input e przyjmujemy, że dla każdej pary (x, v)
-- znajdującej się w input, wartość zmiennej x wynosi v.
-- Możemy założyć, że wyrażenie e jest dobrze typowane, tzn.
-- typecheck (map fst input) e = Ok
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.

--getVariable :: [(Var,Integer)] -> String -> Integer
--getVariable zmienne var = M.lookup var M.fromList(zmienne)

eval :: [(Var,Integer)] -> Expr p -> EvalResult
eval kupa kupad = RuntimeError

--eval zmienne (EIf p bexpr expr1 expr2) =
--	if evalBExpr zmienne bexpr
--		then evalExpr zmienne expr1
--		else evalExpr zmienne expr2

evalExpr :: [(Var,Integer)] -> Expr p -> Integer


evalExpr zmienne (ENum p var) = var

--evalExpr zmienne (EVar p var) = getVariable zmienne var

evalExpr zmienne (EUnary p  UNeg expr) = (- evalExpr zmienne expr)

evalExpr zmienne (EBinary p op expr1 expr2) =
	case op of
		BAdd -> evalExpr zmienne expr1 + evalExpr zmienne expr2
		BMul -> evalExpr zmienne expr1 * evalExpr zmienne expr2
		BSub -> evalExpr zmienne expr1 - evalExpr zmienne expr2
		BDiv -> evalExpr zmienne expr1 `div` evalExpr zmienne expr2
		BMod -> evalExpr zmienne expr1 `mod` evalExpr zmienne expr2

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
