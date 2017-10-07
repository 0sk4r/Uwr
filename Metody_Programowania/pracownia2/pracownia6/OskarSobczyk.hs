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


type FunctionEnv p = Map.Map Var (FunctionDef p)

type Error p = (p, ErrKind)
data ErrKind 
    = EUndefinedVariable Var 
    | ETypeMismatch Type Type
    | EIfMismatch Type Type 
    | ETypeMismatchL Type Type 
    | EMatchNoList Type
    | EPairMismatch Type
    | EFunNotDefined Var
    | EFunction Type

data EValue p
    = Null 
    | MInt Integer
    | MBool Bool 
    | MUnit 
    | MPair (EValue p , EValue p) 
    | MList [EValue p]
    | MFun (Var,Expr p)
      deriving (Show)


instance Show ErrKind where
  show (EUndefinedVariable x) =
    "Undefined variable " ++ show x ++ "."
  show (ETypeMismatch t1 t2)  =
    "Type mismatch: expected " ++ show t1 ++ " but received " ++ show t2 ++ "."
  show (EIfMismatch t1 t2)    =
    "Type mismatch ain the branches of an if: " ++ show t1 ++ " and " ++ show t2 ++ "."
  show (ETypeMismatchL t1 t2)  =
    "Type mismatch in list: head: " ++ show t1 ++ " tail: " ++ show t2 ++ "."
  show (EMatchNoList t1)  =
    "Expected list in match get" ++ show t1 ++ "."
  show (EPairMismatch t1)  =
    "Type mismatch: Expected Pair but received " ++ show t1 ++ "."
  show (EFunNotDefined x) =
    "Function " ++ show x ++ " not defined" 
  show (EFunction x) =
    "Expected function but recived " ++ show x ++ "." 


type TypeEnv = (Var,Type)

initList :: [Var] -> [TypeEnv]
initList lst = [ (x,TInt) | x <- lst ]

getVariable :: (Eq a) => a -> [(a,b)] -> Maybe b 

getVariable var zmienne = lookup var (reverse zmienne)

-- Funkcja sprawdzająca typy
-- Dla wywołania typecheck fs vars e zakładamy, że zmienne występujące
-- w vars są już zdefiniowane i mają typ int, i oczekujemy by wyrażenia e
-- miało typ int
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.
typecheck :: [FunctionDef p] -> [Var] -> Expr p -> TypeCheckResult p

typecheck functions vars expr = 
    --initlist inicjuje liste [(var,TInt)]
    case checkfunctions functions (farrow functions) of
        Nothing -> case checker (initList vars ++ farrow functions) expr of
            Right TInt -> Ok
            Left (p, err) -> Error p $ show err
            _ -> Error  (getData expr) "program not return int"
        Just (p,err) -> Error p $ show err
    where funkcje = farrow functions        


farrow :: [FunctionDef p] -> [TypeEnv]
farrow lst = [ (funcName def,TArrow (funcArgType def) (funcResType def)) | def <- lst]

checkfunctions :: [FunctionDef p] -> [TypeEnv] -> Maybe (Error p)

checkfunctions [] tenv = Nothing

checkfunctions fdefs tenv =
    case checker ([(arg, argType)]++tenv) (funcBody def) of
        Right t1 -> if t1 == retType
            then checkfunctions (tail fdefs) tenv
            else Just (funcPos def, ETypeMismatch t1 (funcResType def))
        Left err -> Just err
    where def = head fdefs
          retType = funcResType def
          arg = funcArg def
          argType = funcArgType def


checker :: [TypeEnv] -> Expr p -> Either (Error p) Type

checker types (ENum p var) = Right TInt

checker types (EBool p var) = Right TBool

checker types (EVar p var) = case getVariable var types of
    Just x -> Right x
    _ -> Left (p, EUndefinedVariable var)

checker types (EUnary p op expr) =
    case op of
        UNeg -> case checker types expr of 
            Right TInt -> Right TInt
            Right t -> Left (p, ETypeMismatch TInt t)
            Left err -> Left err
        UNot -> case checker types expr of 
            Right TBool -> Right TBool 
            Right t -> Left (p, ETypeMismatch TBool t)
            Left err ->Left err

checker types (EBinary p BAdd expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)

checker types (EBinary p BSub expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker types (EBinary p BMod expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)

checker types (EBinary p BMul expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)



checker types (EBinary p BDiv expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TInt
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker types (EBinary p BGt expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker types (EBinary p BGe expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker types (EBinary p BLt expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker types (EBinary p BLe expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)


checker types (EBinary p BEq expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)

checker types (EBinary p BNeq expr1 expr2) = 
    case checker types expr1 of
        Right TInt -> case checker types expr2 of
            Right TInt -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TInt t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TInt t)



checker types (EBinary p BAnd expr1 expr2) = 
    case checker types expr1 of
        Right TBool -> case checker types expr2 of
            Right TBool -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TBool t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TBool t)

checker types (EBinary p BOr expr1 expr2) = 
    case checker types expr1 of
        Right TBool -> case checker types expr2 of
            Right TBool -> Right TBool
            Left err -> Left err
            Right t -> Left (p, ETypeMismatch TBool t)
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TBool t)

checker types (EIf p exbool expr1 expr2) =
    case checker types exbool of
        Right TBool -> case checker types expr1 of
            Right t1 -> case checker types expr2 of
                Right t2 -> if t1 == t2 then Right t1 else Left (p, EIfMismatch t1 t2)
                Left err -> Left err
            Left err -> Left err
        Left err -> Left err
        Right t -> Left (p, ETypeMismatch TBool t)



--kiedy let nadpisuje jakas zmienna dodajemy ja na koniec listy a kiedy bedziemy chcieli z niej skorzystac to zawsze bierzemy 
--najswiezsza zmienna (z konca listy)
checker types (ELet p var expr1 expr2) = 
    case checker types expr1 of
        Right etype -> case checker (types ++ [(var,etype)]) expr2 of
            Right t1 -> Right t1
            Left err -> Left err
        Left err -> Left err




---------------------------------------------------------------------------------
--PRACOWNIA 5
---------------------------------------------------------------------------------

-----------------------
--EUnit
-----------------------
checker types (EUnit p) = Right TUnit


-----------------------
--Pair
-----------------------
checker types (EPair p expr1 expr2) = 
    case checker types expr1 of
        Right type1 -> case checker types expr2 of
            Right type2 -> Right (TPair type1 type2)
            Left err -> Left err
        Left err -> Left err


-----------------------
--EFst
-----------------------
checker types (EFst p expr) = 
    case checker types expr of
        Right (TPair type1 type2) -> Right type1
        Right t -> Left (p, EPairMismatch t)
        Left err -> Left err


-----------------------
--ESnd
-----------------------
checker types (ESnd p expr) = 
    case checker types expr of
        Right (TPair type1 type2) -> Right type2
        Right t -> Left (p, EPairMismatch t)
        Left err -> Left err


-----------------------
--ENil
-----------------------
checker types (ENil p t) = case t of
    TList t2 -> Right (TList t2)
    t2 -> Left (p, ETypeMismatch (TList t2) t2)


-----------------------
--ECons
-----------------------
checker types (ECons p expr1 expr2) = 
    case checker types expr1 of
        Right t1 -> case checker types expr2 of
            Right (TList t2) -> 
                if t1 == t2 then Right (TList t1) else Left (p, ETypeMismatchL t1 t2)
            Right t -> Left (p, ETypeMismatch (TList t1) t)
            Left err -> Left err
        Left err -> Left err


-----------------------
--EMatchL
-----------------------
checker types (EMatchL p expr1 nilclause (var1, var2, expr2)) = 
    case checker types expr1 of
        Right (TList type1) -> case checker types nilclause of
            Right type2 -> case checker eenv expr2 of
                Right type3 -> if type2 == type3 
                    then Right type2
                    else Left (p, ETypeMismatch type2 type3)
                Left err -> Left err
            Left err -> Left err
            where eenv =types ++ [(var1, type1),(var2,TList type1)] --rozszerzone srodowisko
        Right t -> Left (p, EMatchNoList t)
        Left err -> Left err



-------------------------------------------------------------------------------
--PRACOWNIA 6
-------------------------------------------------------------------------------

-----------------------
--EApp
-----------------------
checker types (EApp p expr1 expr2) = 
    case checker types expr1 of
        Right (TArrow t1 t2) -> case checker types expr2 of
            Right t3 -> if t1 == t3 then Right t2 else Left (p, ETypeMismatch t1 t3)
            Left err -> Left err
        Left err -> Left err
        Right t -> Left (p, EFunction t)


-----------------------
--EFn
-----------------------        
checker types (EFn p var t1 expr) =
    case checker (types ++ [(var,t1)]) expr of
        Right t2 -> Right (TArrow t1 t2)
        Left err -> Left err

--funkcja szukajaca funkcji w środowisku, zwraca definicje funkcji
findFnc :: FunctionEnv p -> Var -> Maybe (FunctionDef p)
findFnc functionEnv identifier = Map.lookup identifier functionEnv



-- Funkcja obliczająca wyrażenia
-- Dla wywołania eval fs input e przyjmujemy, że dla każdej pary (x, v)
-- znajdującej się w input, wartość zmiennej x wynosi v.
-- Możemy założyć, że definicje funckcji fs oraz wyrażenie e są dobrze
-- typowane, tzn. typecheck fs (map fst input) e = Ok
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.

initList2 :: [(Var,Integer)] -> [(Var,EValue p)]
initList2 lst = [ (x,MInt int) | (x, int) <- lst]

initFenv :: [FunctionDef p] -> [(Var,EValue p)]
initFenv f = [(funcName x, MFun (funcArg x, funcBody x)) | x <- f]



eval :: [FunctionDef p] -> [(Var,Integer)] -> Expr p -> EvalResult
eval fdefs varenv expr =
    case evalExpr ((initList2 varenv)++fenv) expr of
        Right (MInt val) -> Value val
        Left err -> RuntimeError
    where fenv = initFenv fdefs







evalExpr :: [(Var,EValue p)] -> Expr p -> Either String (EValue p)

evalExpr varenv (ENum p var) = Right (MInt var)

evalExpr varenv (EBool p var) =
    case var of
        True -> Right (MBool True)
        False -> Right (MBool False)


evalExpr varenv (EVar p var) = case getVariable var varenv of
    Just x -> Right x
    otherwise -> Left "var undefined"

-----------------------
--Operatory unarne
-----------------------


evalExpr varenv (EUnary p UNeg expr) =
    case evalExpr varenv expr of
        Right (MInt val) -> Right (MInt (-val))
        Left err -> Left err

evalExpr varenv (EUnary p UNot expr) =
    case evalExpr varenv expr of
        Right (MBool val) -> Right (MBool (not val))
        Left err -> Left err


-----------------------
--Operatory arytmetyczne
-----------------------

evalExpr varenv (EBinary p BAdd expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MInt (val1 + val2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BSub expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MInt (val1 - val2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BMul expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MInt (val1 * val2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BDiv expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt 0) -> Left "div by 0"
            Right (MInt val2) -> Right (MInt (val1 `div` val2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BMod expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt 0) -> Left "mod by 0"
            Right (MInt val2) -> Right (MInt (val1 `mod` val2))
            Left err -> Left err
        Left err -> Left err


-----------------------
--Operatory logiczne
-----------------------
evalExpr varenv (EBinary p BAnd expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MBool b1) -> case evalExpr varenv expr2 of
            Right (MBool b2) -> Right (MBool (b1 && b2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BOr expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MBool b1) -> case evalExpr varenv expr2 of
            Right (MBool b2) -> Right (MBool (b1 || b2))
            Left err -> Left err
        Left err -> Left err


-----------------------
--Operatory porownania
-----------------------

evalExpr varenv (EBinary p BLt expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 < val2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BLe expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 <= val2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BGt expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 > val2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BGe expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 >= val2))
            Left err -> Left err
        Left err -> Left err


evalExpr varenv (EBinary p BEq expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 == val2))
            Left err -> Left err
        Left err -> Left err

evalExpr varenv (EBinary p BNeq expr1 expr2) =
    case evalExpr varenv expr1 of
        Right (MInt val1) -> case evalExpr varenv expr2 of
            Right (MInt val2) -> Right (MBool (val1 /= val2))
            Left err -> Left err
        Left err -> Left err

-----------------------
--If
-----------------------

evalExpr varenv (EIf p exprbool expr1 expr2) =
    case evalExpr varenv exprbool of
        Right (MBool True) -> case evalExpr varenv expr1 of
            Right val -> Right val
            Left err -> Left err
        Right (MBool False) -> case evalExpr varenv expr2 of
            Right val -> Right val
            Left err -> Left err
        Left err -> Left err

-----------------------
--Let
-----------------------

evalExpr varenv (ELet p var expr1 expr2) =
    case evalExpr varenv expr1 of
        Right val -> case evalExpr (varenv ++ [(var,val)]) expr2 of
            Right val2 -> Right val2
            Left err -> Left err
        Left err -> Left err



---------------------------------------------------------------------------------
--PRACOWNIA 5
---------------------------------------------------------------------------------

evalExpr varenv (EUnit p) = Right MUnit


-----------------------
--Pair
-----------------------
evalExpr varenv (EPair p expr1 expr2) =
    case evalExpr varenv expr1 of
        Right val1 -> case evalExpr varenv expr2 of
            Right val2 -> Right (MPair (val1,val2))
            Left err -> Left err
        Left err -> Left err


-----------------------
--Fst
-----------------------
evalExpr varenv (EFst p expr) =
    case evalExpr varenv expr of
        Right (MPair (val1,val2)) -> Right val1
        Left err -> Left err


-----------------------
--Snd
-----------------------
evalExpr varenv (ESnd p expr) =
    case evalExpr varenv expr of
        Right (MPair (val1,val2)) -> Right val2
        Left err -> Left err


-----------------------
--ENil
-----------------------

evalExpr varenv (ENil _ _) = Right Null

-----------------------
--ECons
-----------------------

evalExpr varenv (ECons _ expr1 expr2) = 
    case evalExpr varenv expr1 of
        Right val1 -> case evalExpr varenv expr2 of
            Right val2 -> Right (MList (val1 : [val2]))
            Left err -> Left err
        Left err -> Left err

-----------------------
--EMatch
-----------------------

evalExpr varenv (EMatchL _ elist nilclause (h,t,conslause)) =
    case list of
        Right Null -> evalExpr varenv nilclause
        Right (MList (x:[xs])) -> evalExpr (varenv ++ [(h,x),(t,xs)]) conslause
        Left err -> Left err
        where list = evalExpr varenv elist



------------------------------------------------------------------------------
--PRACOWNIA 6
-------------------------------------------------------------------------------

evalExpr varenv (EFn p var t expr) = Right (MFun (var, expr))

-----------------------
--EApp
-----------------------

evalExpr varenv (EApp p expr1 expr2) =
    case evalExpr varenv expr2 of 
        Left err -> Left err
        Right val -> case expr1 of
            (EFn p var t exprLambda) -> case evalExpr (varenv ++ [(var,val)]) exprLambda of
                Right val -> Right val
                Left err -> Left err
            otherwise -> case evalExpr varenv expr1 of
                Right (MFun (var1,body)) -> evalExpr (varenv ++ [(var1,val)]) body
