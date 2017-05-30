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
import qualified Data.Map  as Map
-- Funkcja sprawdzająca typy
-- Dla wywołania typecheck fs vars e zakładamy, że zmienne występujące
-- w vars są już zdefiniowane i mają typ int, i oczekujemy by wyrażenia e
-- miało typ int
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.

type TypeEnv = (String,Type)
data Error p = ErrorType p String deriving Show
type FunctionEnv p = Map.Map FSym (FunctionDef p)

getVariable :: (Eq a) => a -> [(a,b)] -> Maybe b 

getVariable var zmienne = lookup var (reverse zmienne)

typecheck :: [FunctionDef p] -> [Var] -> Expr p -> TypeCheckResult p

typecheck functions vars expr = 
    --initlist inicjuje liste [(var,TInt)]
    case checker (Map.fromList $ zip (map funcName funcs) funcs) (initList vars) expr of
        Right TInt -> Ok
        Left (ErrorType p err) -> Error p err
        otherwise -> Error  (getData expr) "program not return int"


checker :: [FunctionEnv p] -> [TypeEnv] -> Expr p -> Either (Error p) Type

checker functions types (ENum p var) = Right TInt

checker functions types (EBool p var) = Right TBool

checker functions types (EVar p var) = case getVariable var types of
    Just x -> Right x
    otherwise -> Left (ErrorType p ("undefined var: " ++ var))

checker functions types (EUnary p op expr) =
    case op of
        UNeg -> case checker functions types expr of 
            Right TInt -> Right TInt
            otherwise -> Left (ErrorType p "-bool (expected int)")
        UNot -> case checker functions types expr of 
            Right TBool -> Right TBool 
            otherwise -> Left (ErrorType p "~int (expected bool)")

checker functions types (EBinary p BAdd expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            otherwise -> Left (ErrorType p "... + bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) + ...")

checker functions types (EBinary p BSub expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            otherwise -> Left (ErrorType p "... - bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) - ...")


checker functions types (EBinary p BMod expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            otherwise -> Left (ErrorType p "... mod bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) mod ...")


checker functions types (EBinary p BMul expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            otherwise -> Left (ErrorType p "... * bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) * ...")



checker functions types (EBinary p BDiv expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            otherwise -> Left (ErrorType p "... div bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) div ...")



checker functions types (EBinary p BGt expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            otherwise -> Left (ErrorType p "... > bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) < ...")


checker functions types (EBinary p BGe expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            otherwise -> Left (ErrorType p "... => bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) <= ...")


checker functions types (EBinary p BLt expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            otherwise -> Left (ErrorType p "... < bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) < ...")


checker functions types (EBinary p BLe expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            otherwise -> Left (ErrorType p "... <= bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) <= ...")


checker functions types (EBinary p BEq expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            otherwise -> Left (ErrorType p "... = bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) = ...")

checker functions types (EBinary p BNeq expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            otherwise -> Left (ErrorType p "... <> bool (expected int)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "bool (expected int) <> ...")



checker functions types (EBinary p BAnd expr1 expr2) = 
    case checker functions types expr1 of
        Right TBool -> case checker functions types expr2 of
            Right TBool -> Right TBool
            Left err -> Left err
            otherwise -> Left (ErrorType p "... and int (expected bool)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "int (expected bool) and ...")

checker functions types (EBinary p BOr expr1 expr2) = 
    case checker functions types expr1 of
        Right TBool -> case checker functions types expr2 of
            Right TBool -> Right TBool
            Left err -> Left err
            otherwise -> Left (ErrorType p "... or int (expected bool)")
        Left err -> Left err
        otherwise -> Left (ErrorType p "int (expected bool) or ...")

checker functions types (EIf p exbool expr1 expr2) =
    case checker functions types exbool of
        Right TBool -> case checker functions types expr1 of
            Right TInt -> case checker functions types expr2 of
                Right TInt -> Right TInt
                Left err -> Left err
                otherwise -> Left (ErrorType p "int and bool (expected int) in if")
            Left err -> Left err
            Right TBool -> case checker functions types expr2 of
                Right TBool -> Right TBool
                Left err -> Left err
                otherwise -> Left (ErrorType p "bool and int (expected bool) in if")
        Left err -> Left err
        otherwise -> Left (ErrorType p "if (no bool expr) then ...")



--kiedy let nadpisuje jakas zmienna dodajemy ja na koniec listy a kiedy bedziemy chcieli z niej skorzystac to zawsze bierzemy 
--najswiezsza zmienna (z konca listy)
checker functions types (ELet p var expr1 expr2) = 
    case checker functions types expr1 of
        Right TBool -> case checker functions (types ++ [(var,TBool)]) expr2 of
            Right TBool -> Right TBool
            Right TInt -> Right TInt
            Left err -> Left err
        Right TInt -> case checker functions (types ++ [(var,TInt)]) expr2 of
            Right TBool -> Right TBool
            Right TInt -> Right TInt
            Left err -> Left err
        Left err -> Left err




---------------------------------------------------------------------------------
--PRACOWNIA 5
---------------------------------------------------------------------------------
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

checker functions types (ENil p typ) = Right (TList typ)

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

checker functions types (EApp p fsym expr) = 
  case findFnc functions fsym of
      Just definition -> case checker functions types expr of
          Right (funcArgType definition) -> Right (funcResType definition)
          Left err -> Left err
          otherwise -> Left (ErrorType p "argumenty nie zgadzaja sie")
      Nothing -> Left (ErrorType p "nie ma takiej funkcji")
        

findFnc :: FunctionEnv p -> FSym -> Maybe (FunctionDef p)
findFnc functionEnv identifier = Map.lookup identifier functionEnv

-- Funkcja obliczająca wyrażenia
-- Dla wywołania eval fs input e przyjmujemy, że dla każdej pary (x, v)
-- znajdującej się w input, wartość zmiennej x wynosi v.
-- Możemy założyć, że definicje funckcji fs oraz wyrażenie e są dobrze
-- typowane, tzn. typecheck fs (map fst input) e = Ok
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.
eval :: [FunctionDef p] -> [(Var,Integer)] -> Expr p -> EvalResult
eval _ _ _ = RuntimeError