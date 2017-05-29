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

-- Funkcja sprawdzająca typy
-- Dla wywołania typecheck fs vars e zakładamy, że zmienne występujące
-- w vars są już zdefiniowane i mają typ int, i oczekujemy by wyrażenia e
-- miało typ int
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.

type TypeEnv = (String,Type)


typecheck :: [FunctionDef p] -> [Var] -> Expr p -> TypeCheckResult p
typecheck _ _ _ = Ok


checker :: [FunctionDef p] -> [TypeEnv] -> Expr p -> Either (Error p) Type

checker functions types (EUnit p) = Right TUnit

checker functions types (EPair p expr1 expr2) = 
	case checker functions types expr1 of
		Right type1 -> case checker functions types expr2 of
			Right type2 -> Right (TPair type1 type2)
			Left err -> Left err
		Left err -> Left err

checker functions types (EFst p expr) = 
	case checker functions types expr of
		Right (TPair type1 type2) -> Right type1
		Left err -> Left err

checker functions types (ESnd p expr) = 
	case checker functions types expr of
		Right (TPair type1 type2) -> Right type2
		Left err -> Left err

checker functions types (ENil p type) = Right (TList type)

checker functions types (ECons p expr1 expr2) = 
	case checker functions types expr1 of
		Right type1 -> case checker functions types expr2 of
			Right (TList type1) -> Right (TList type1)
			Left err -> Left err
			otherwise -> Left (ErrorType p "rozne typy w liscie")
		Left err -> Left err

checker functions types (EMatchL p expr1 nilclause (var1, var2, expr2)) = 
	case checker functions types expr1 of
		Right (TList type1) -> case checker functions types expr2 of
			Right type2 -> case checker functions (types ++ [(var1, type1),(var2,(TList type2))]) expr2 of
				Right type2 -> Right type2
				Left err -> Left err
				otherwise -> Left (ErrorType p "diff type in match")
			Left err -> Left err
		otherwise -> Left (ErrorType p "no list in match")


-- Funkcja obliczająca wyrażenia
-- Dla wywołania eval fs input e przyjmujemy, że dla każdej pary (x, v)
-- znajdującej się w input, wartość zmiennej x wynosi v.
-- Możemy założyć, że definicje funckcji fs oraz wyrażenie e są dobrze
-- typowane, tzn. typecheck fs (map fst input) e = Ok
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.
eval :: [FunctionDef p] -> [(Var,Integer)] -> Expr p -> EvalResult
eval _ _ _ = RuntimeError