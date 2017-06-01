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
--data Error p = ErrorType p String deriving Show
type FunctionEnv p = Map.Map FSym (FunctionDef p)

type Error p = (p, ErrKind)
data ErrKind 
    = EUndefinedVariable Var 
    | ETypeMismatch Type Type
    | EIfMismatch Type Type 
    | ETypeMismatchL Type Type 
    | EMatchNoList Type
    | EPairMismatch Type


instance Show ErrKind where
  show (EUndefinedVariable x) =
    "Undefined variable " ++ show x ++ "."
  show (ETypeMismatch t1 t2)  =
    "Type mismatch: expected " ++ show t1 ++ " but received " ++ show t2 ++ "."
  show (EIfMismatch t1 t2)    =
    "Type mismatch in the branches of an if: " ++ show t1 ++ " and " ++ show t2 ++ "."
  show (ETypeMismatchL t1 t2)  =
    "Type mismatch in list: head: " ++ show t1 ++ " tail: " ++ show t2 ++ "."
  show (EMatchNoList t1)  =
    "Expected list in match get" ++ show t1 ++ "."
  show (EPairMismatch t1)  =
    "Type mismatch: expected Pair but received " ++ show t1 ++ "."

data EValue 
    = Empty 
    | MInt Integer 
    | MBool Bool 
    | MUnit 
    | MPair (EValue, EValue) 
    | MList [EValue]
      deriving (Show, Eq, Ord)

initList :: [Var] -> [TypeEnv]
initList lst = [ (x,TInt) | x <- lst ]


getVariable :: (Eq a) => a -> [(a,b)] -> Maybe b 

getVariable var zmienne = lookup var (reverse zmienne)

typecheck :: [FunctionDef p] -> [Var] -> Expr p -> TypeCheckResult p

typecheck functions vars expr = 
    --initlist inicjuje liste [(var,TInt)]
    case checkfunctions functions fenv of
        Nothing -> case checker fenv (initList vars) expr of
            Right TInt -> Ok
            Left (p, err) -> Error p $ show err
            otherwise -> Error  (getData expr) "program not return int"
        Just (p,err) -> Error p $ show err
    where fenv = (Map.fromList $ zip (map funcName functions) functions)


checkfunctions :: [FunctionDef p] -> FunctionEnv p -> Maybe (Error p)

checkfunctions [] fenv = Nothing

checkfunctions fdefs fenv =
    case checker fenv ([(funcArg def, funcArgType def)]) (funcBody def) of
        Right t1 -> if t1 == (funcResType def) 
            then checkfunctions (tail fdefs) fenv
            else Just ((funcPos def), ETypeMismatch t1 (funcResType def))
        Left err -> Just err
    where def = head fdefs


checker :: FunctionEnv p -> [TypeEnv] -> Expr p -> Either (Error p) Type

checker functions types (ENum p var) = Right TInt

checker functions types (EBool p var) = Right TBool

checker functions types (EVar p var) = case getVariable var types of
    Just x -> Right x
    otherwise -> Left (p, EUndefinedVariable var)

checker functions types (EUnary p op expr) =
    case op of
        UNeg -> case checker functions types expr of 
            Right TInt -> Right TInt
            Right t -> Left (p, ETypeMismatch TInt t)
            Left err -> Left err
        UNot -> case checker functions types expr of 
            Right TBool -> Right TBool 
            Right t -> Left (p, ETypeMismatch TBool t)
            Left err ->Left err

checker functions types (EBinary p BAdd expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)

checker functions types (EBinary p BSub expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker functions types (EBinary p BMod expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)

checker functions types (EBinary p BMul expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)



checker functions types (EBinary p BDiv expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker functions types (EBinary p BGt expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker functions types (EBinary p BGe expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker functions types (EBinary p BLt expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker functions types (EBinary p BLe expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker functions types (EBinary p BEq expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)

checker functions types (EBinary p BNeq expr1 expr2) = 
    case checker functions types expr1 of
        Right TInt -> case checker functions types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)



checker functions types (EBinary p BAnd expr1 expr2) = 
    case checker functions types expr1 of
        Right TBool -> case checker functions types expr2 of
            Right TBool -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TBool t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TBool t)

checker functions types (EBinary p BOr expr1 expr2) = 
    case checker functions types expr1 of
        Right TBool -> case checker functions types expr2 of
            Right TBool -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TBool t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TBool t)

checker functions types (EIf p exbool expr1 expr2) =
    case checker functions types exbool of
        Right TBool -> case checker functions types expr1 of
            Right t1 -> case checker functions types expr2 of
                Right t2 -> if t1 == t2 then Right t1 else Left (p, EIfMismatch t1 t2)
                Left err -> Left err
            Left err -> Left err
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TBool t)



--kiedy let nadpisuje jakas zmienna dodajemy ja na koniec listy a kiedy bedziemy chcieli z niej skorzystac to zawsze bierzemy 
--najswiezsza zmienna (z konca listy)
checker functions types (ELet p var expr1 expr2) = 
    case checker functions types expr1 of
        Right etype -> case checker functions (types ++ [(var,etype)]) expr2 of
            Right t1 -> Right t1
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
        Right t -> Left (p, EPairMismatch t)
        Left err -> Left err

checker functions types (ESnd p expr) = 
    case checker functions types expr of
        Right (TPair type1 type2) -> Right type2
        Right t -> Left (p, EPairMismatch t)
        Left err -> Left err

checker functions types (ENil p typ) = Right (typ)

checker functions types (ECons p expr1 expr2) = 
    case checker functions types expr1 of
        Right t1 -> case checker functions types expr2 of
            Right (TList t2) -> 
                if t1 == t2 then Right (TList t1) else Left (p, ETypeMismatchL t1 t2)
            Left err -> Left err
        Left err -> Left err

checker functions types (EMatchL p expr1 nilclause (var1, var2, expr2)) = 
    case checker functions types expr1 of
        Right (TList type1) -> case checker functions types nilclause of
            Right type2 -> case checker functions (types ++ [(var1, type1),(var2,(TList type1))]) expr2 of
                Right type3 -> if type2 == type3 
                    then Right type2
                    else Left (p, ETypeMismatch type2 type3)
                Left err -> Left err
            Left err -> Left err
        Right t -> Left (p, EMatchNoList t)
        Left err -> Left err

checker functions types (EApp p fsym expr) = 
    case findFnc functions fsym of
        Just definition -> case checker functions types expr of 
            Right t -> if t == tf 
                then Right (funcResType definition) 
                else Left (p, ETypeMismatch tf t)
            Left err -> Left err
            where tf = funcArgType definition
        Nothing -> Left (p, ETypeMismatch TInt TInt)
        

findFnc :: FunctionEnv p -> FSym -> Maybe (FunctionDef p)
findFnc functionEnv identifier = Map.lookup identifier functionEnv











-- Funkcja obliczająca wyrażenia
-- Dla wywołania eval fs input e przyjmujemy, że dla każdej pary (x, v)
-- znajdującej się w input, wartość zmiennej x wynosi v.
-- Możemy założyć, że definicje funckcji fs oraz wyrażenie e są dobrze
-- typowane, tzn. typecheck fs (map fst input) e = Ok
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.

initList2 :: [(Var,Integer)] -> [(Var,EValue)]
initList2 lst = [ (x,MInt int) | (x, int) <- lst]




eval :: [FunctionDef p] -> [(Var,Integer)] -> Expr p -> EvalResult
eval fdefs varenv expr =
    case evalExpr fenv (initList2 varenv) expr of
        Right (MInt val) -> Value val
        Left err -> RuntimeError
    where fenv = (Map.fromList $ zip (map funcName fdefs) fdefs)



evalExpr :: FunctionEnv p -> [(Var,EValue)] -> Expr p -> Either String EValue

evalExpr fenv varenv (ENum p var) = Right (MInt var)

evalExpr fenv varenv (EBool p var) =
    case var of
        True -> Right (MBool True)
        False -> Right (MBool False)


-- ???????????
evalExpr fenv varenv (EVar p var) = case getVariable var varenv of
    Just x -> Right x
    otherwise -> Left "var undefined"

-----------------------
--Operatory unarne
-----------------------


evalExpr fenv varenv (EUnary p UNeg expr) =
    case evalExpr fenv varenv expr of
        Right (MInt val) -> Right (MInt (-val))
        Left err -> Left err

evalExpr fenv varenv (EUnary p UNot expr) =
    case evalExpr fenv varenv expr of
        Right (MBool val) -> Right (MBool (not val))
        Left err -> Left err


-----------------------
--Operatory arytmetyczne
-----------------------

evalExpr fenv varenv (EBinary p BAdd expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MInt (val1 + val2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BSub expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MInt (val1 - val2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BMul expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MInt (val1 * val2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BDiv expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt 0) -> Left "div by 0"
            Right (MInt val2) -> Right (MInt (val1 `div` val2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BMod expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt 0) -> Left "mod by 0"
            Right (MInt val2) -> Right (MInt (val1 `mod` val2))
            Left err -> Left err
        Left err -> Left err


-----------------------
--Operatory logiczne
-----------------------
evalExpr fenv varenv (EBinary p BAnd expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MBool b1) -> case evalExpr fenv varenv expr2 of
            Right (MBool b2) -> Right (MBool (b1 && b2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BOr expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MBool b1) -> case evalExpr fenv varenv expr2 of
            Right (MBool b2) -> Right (MBool (b1 || b2))
            Left err -> Left err
        Left err -> Left err


-----------------------
--Operatory porownania
-----------------------

evalExpr fenv varenv (EBinary p BLt expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 < val2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BLe expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 <= val2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BGt expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 > val2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BGe expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 >= val2))
            Left err -> Left err
        Left err -> Left err


evalExpr fenv varenv (EBinary p BEq expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 == val2))
            Left err -> Left err
        Left err -> Left err

evalExpr fenv varenv (EBinary p BNeq expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right (MInt val1) -> case evalExpr fenv varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 /= val2))
            Left err -> Left err
        Left err -> Left err

-----------------------
--If
-----------------------

evalExpr fenv varenv (EIf p exprbool expr1 expr2) =
    case evalExpr fenv varenv exprbool of
        Right (MBool True) -> case evalExpr fenv varenv expr1 of
            Right val -> Right val
            Left err -> Left err
        Right (MBool False) -> case evalExpr fenv varenv expr2 of
            Right val -> Right val
            Left err -> Left err
        Left err -> Left err

-----------------------
--Let
-----------------------

evalExpr fenv varenv (ELet p var expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        --Let w ktorym nadpisywana jest jakas wczesza zmienna bedzie dzialac poniewaz kiedy program dochodzi do EVar 
        --najpierw przesukuje od konca tablicee wartosci boolowskich a dopieto potem int
        Right val -> case evalExpr fenv (varenv ++ [(var,val)]) expr2 of
            Right val2 -> Right val2
            Left err -> Left err
        --Jezeli zmienna ktora nadpisujemy ma miec wartosc int to mozemy usunac wystapienia tej zmiennej z tablicy bool poniewaz w przyslosci
        --i tak nie wykorzystamy tych wartosci. Delete dziala w taki sposob ze jesli usuwanego elementu nie ma w tablicy to zwroci nie zmieniona tablice.
        --Czyli mozemy bezpiecznie usuwac "nie istniejace" wpisy w tablicy bool
        Left err -> Left err



---------------------------------------------------------------------------------
--PRACOWNIA 5
---------------------------------------------------------------------------------

evalExpr fenv varenv (EUnit p) = Right MUnit


-----------------------
--Pair
-----------------------
evalExpr fenv varenv (EPair p expr1 expr2) =
    case evalExpr fenv varenv expr1 of
        Right val1 -> case evalExpr fenv varenv expr2 of
            Right val2 -> Right (MPair (val1,val2))
            Left err -> Left err
        Left err -> Left err


-----------------------
--Fst
-----------------------
evalExpr fenv varenv (EFst p expr) =
    case evalExpr fenv varenv expr of
        Right (MPair (val1,val2)) -> Right val1
        Left err -> Left err


-----------------------
--Snd
-----------------------
evalExpr fenv varenv (ESnd p expr) =
    case evalExpr fenv varenv expr of
        Right (MPair (val1,val2)) -> Right val2
        Left err -> Left err

-----------------------
--EApp
-----------------------

evalExpr fenv varenv (EApp p identifier expr) =
    case findFnc fenv identifier of
        Just def -> evalExpr fenv varenv (ELet p (funcArg def) expr (funcBody def))
        Nothing -> Left "lol"

-----------------------
--ENil
-----------------------

evalExpr fenv varenv (ENil _ _) = Right Empty

-----------------------
--ECons
-----------------------

evalExpr fenv varenv (ECons _ expr1 expr2) = 
    case evalExpr fenv varenv expr1 of
        Right val1 -> case evalExpr fenv varenv expr2 of
            Right val2 -> Right (MList (val1 : [val2]))
            Left err -> Left err
        Left err -> Left err

-----------------------
--EMatch
-----------------------

evalExpr fenv varenv (EMatchL _ elist nilclause (h,t,conslause)) =
    case list of
        Right Empty -> evalExpr fenv varenv nilclause
        Right (MList (x:[xs])) -> evalExpr fenv (varenv ++ [(h,x),(t,xs)]) conslause
        where list = evalExpr fenv varenv elist