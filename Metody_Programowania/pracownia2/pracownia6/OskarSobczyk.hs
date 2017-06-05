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

type Error p = (p, ErrKind)
data ErrKind 
    = EUndefinedVariable Var 
    | ETypeMismatch Type Type
    | EIfMismatch Type Type 
    | ETypeMismatchL Type Type 
    | EMatchNoList Type
    | EPairMismatch Type
    | EFunNotDefined Var


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
    "Type mismatch: Expected Pair but received " ++ show t1 ++ "."
  show (EFunNotDefined x) =
    "Function " ++ show x ++ " not defined" 



type TypeEnv = (String,Type)


-- Funkcja sprawdzająca typy
-- Dla wywołania typecheck fs vars e zakładamy, że zmienne występujące
-- w vars są już zdefiniowane i mają typ int, i oczekujemy by wyrażenia e
-- miało typ int
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.
typecheck :: [FunctionDef p] -> [Var] -> Expr p -> TypeCheckResult p
typecheck = undefined

farrow :: [FunctionDef p] -> [(String,Type)]
farrow lst = [ ((funcName def),TArrow (funcArgType def) (funcResType def)) | def <- lst]

checkfunctions :: [FunctionDef p] -> FunctionEnv p -> Maybe (Error p)

checkfunctions [] fenv = Nothing

checkfunctions fdefs fenv =
    case checker fenv ([(arg, argType)]) (funcBody def) of
        Right t1 -> if t1 == retType
            then checkfunctions (tail fdefs) fenv
            else Just ((funcPos def), ETypeMismatch t1 (funcResType def))
        Left err -> Just err
    where def = head fdefs
          retType = funcResType def
          arg = funcArg def
          argType = funcArgType def


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

-----------------------
--EUnit
-----------------------
checker functions types (EUnit p) = Right TUnit


-----------------------
--Pair
-----------------------
checker functions types (EPair p expr1 expr2) = 
    case checker functions types expr1 of
        Right type1 -> case checker functions types expr2 of
            Right type2 -> Right (TPair type1 type2)
            Left err -> Left err
        Left err -> Left err


-----------------------
--EFst
-----------------------
checker functions types (EFst p expr) = 
    case checker functions types expr of
        Right (TPair type1 type2) -> Right type1
        Right t -> Left (p, EPairMismatch t)
        Left err -> Left err


-----------------------
--ESnd
-----------------------
checker functions types (ESnd p expr) = 
    case checker functions types expr of
        Right (TPair type1 type2) -> Right type2
        Right t -> Left (p, EPairMismatch t)
        Left err -> Left err


-----------------------
--ENil
-----------------------
checker functions types (ENil p t) = case t of
    TList t2 -> Right (TList t2)
    t2 -> Left (p, ETypeMismatch (TList t2) t2)


-----------------------
--ECons
-----------------------
checker functions types (ECons p expr1 expr2) = 
    case checker functions types expr1 of
        Right t1 -> case checker functions types expr2 of
            Right (TList t2) -> 
                if t1 == t2 then Right (TList t1) else Left (p, ETypeMismatchL t1 t2)
            Right t -> Left (p, ETypeMismatch (TList t1) t)
            Left err -> Left err
        Left err -> Left err


-----------------------
--EMatchL
-----------------------
checker functions types (EMatchL p expr1 nilclause (var1, var2, expr2)) = 
    case checker functions types expr1 of
        Right (TList type1) -> case checker functions types nilclause of
            Right type2 -> case checker functions eenv expr2 of
                Right type3 -> if type2 == type3 
                    then Right type2
                    else Left (p, ETypeMismatch type2 type3)
                Left err -> Left err
            Left err -> Left err
            where eenv =types ++ [(var1, type1),(var2,(TList type1))] --rozszerzone srodowisko
        Right t -> Left (p, EMatchNoList t)
        Left err -> Left err


-----------------------
--EApp
-----------------------
checker functions types (EApp p epxr1 expr2) = 
    case findFnc functions fsym of
        Just definition -> case checker functions types expr of 
            Right t -> if t == tf 
                then Right (funcResType definition) 
                else Left (p, ETypeMismatch tf t)
            Left err -> Left err
            where tf = funcArgType definition --typ argumentu funkcji
        Nothing -> Left (p, EFunNotDefined fsym)
        

--funkcja szukajaca funkcji w środowisku, zwraca definicje funkcji
findFnc :: FunctionEnv p -> FSym -> Maybe (FunctionDef p)
findFnc functionEnv identifier = Map.lookup identifier functionEnv



-- Funkcja obliczająca wyrażenia
-- Dla wywołania eval fs input e przyjmujemy, że dla każdej pary (x, v)
-- znajdującej się w input, wartość zmiennej x wynosi v.
-- Możemy założyć, że definicje funckcji fs oraz wyrażenie e są dobrze
-- typowane, tzn. typecheck fs (map fst input) e = Ok
-- UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jej definicję.
eval :: [FunctionDef p] -> [(Var,Integer)] -> Expr p -> EvalResult
eval = undefined