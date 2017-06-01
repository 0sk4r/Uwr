data Value =  Empty | MInt Integer | MBool Bool | MUnit | MPair (Value, Value) | MList [Value]
      deriving (Show, Eq, Ord)


--evalExpr przyjmuje tablice wartosci int [(Var, wartosc int)] oraz tablice wartosci boolowskich [(Var, wartosc bool)] 
--zwraca Integer lub string. Strign bedzie reprezentowac wartosci boolowskie "true"/"false" lub error 
evalExpr :: [FunctionEnv p] -> [(Var,Value)] -> Expr p -> Either String Value

evalExpr fenv varenv (ENum p var) = Right MInt var

evalExpr fenv varenv (EBool p var) =
	case var of
		True -> Right MBool True
		False -> Right MBool False


-- ???????????
evalExpr fenv varenv (EVar p var) = case getVariable var varbool of
	Just x -> Left x
	otherwise -> case getVariable var fenv varenv of
		Just x -> Right x
		otherwise -> Left "var undefined"

-----------------------
--Operatory unarne
-----------------------


evalExpr fenv varenv (EUnary p UNeg expr) =
	case evalExpr fenv varenv expr of
		Right MInt val -> Right MInt (-val)
		Left err -> Left err

evalExpr fenv varenv (EUnary p UNot expr) =
	case evalExpr fenv varenv expr of
		Right MBool val -> Right Mbool (not val)
		Left err -> Left err


-----------------------
--Operatory arytmetyczne
-----------------------

evalExpr fenv varenv (EBinary p BAdd expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MInt (val1 + val2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BSub expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MInt (val1 - val2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BMul expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MInt (val1 * val2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BDiv expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right 0 -> Left "div by 0"
			Right MInt val2 -> Right MInt (val1 `div` val2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BMod expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right 0 -> Left "mod by 0"
			Right MInt val2 -> Right MInt (val1 `mod` val2)
			Left err -> Left err
		Left err -> Left err


-----------------------
--Operatory logiczne
-----------------------
evalExpr fenv varenv (EBinary p BAnd expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MBool b1 -> case evalExpr fenv varenv expr2 of
			Right MBool b2 -> Right MBool (b1 && b2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BOr expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MBool b1 -> case evalExpr fenv varenv expr2 of
			Right MBool b2 -> Right MBool (b1 || b2)
			Left err -> Left err
		Left err -> Left err


-----------------------
--Operatory porownania
-----------------------

evalExpr fenv varenv (EBinary p BLt expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MBool (val1 < val2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BLe expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MBool (val1 <= val2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BGt expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MBool (val1 > val2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BGe expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MBool (val1 >= val2)
			Left err -> Left err
		Left err -> Left err


evalExpr fenv varenv (EBinary p BEq expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MBool (val1 == val2)
			Left err -> Left err
		Left err -> Left err

evalExpr fenv varenv (EBinary p BNeq expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		Right MInt val1 -> case evalExpr fenv varenv expr2 of
			Right MInt val2 -> Right MBool (val1 /= val2)
			Left err -> Left err
		Left err -> Left err

-----------------------
--If
-----------------------

evalExpr fenv varenv (EIf p exprbool expr1 expr2) =
	case evalExpr fenv varenv exprbool of
		Right MBool True -> case evalExpr fenv varenv expr1 of
			Right type val -> Right type val
			Left err -> Left err
		Right MBool False -> case evalExpr fenv varenv expr2 of
			Right type val -> Right type val
			Left err -> Left err
		Left err -> Left err

-----------------------
--Let
-----------------------

evalExpr fenv varenv (ELet p var expr1 expr2) =
	case evalExpr fenv varenv expr1 of
		--Let w ktorym nadpisywana jest jakas wczesza zmienna bedzie dzialac poniewaz kiedy program dochodzi do EVar 
		--najpierw przesukuje od konca tablicee wartosci boolowskich a dopieto potem int
		Right val -> case evalExpr fenv (varenv ++ [(var,val)] expr2 of
			Right val -> Right val
			Left err -> Left err
		--Jezeli zmienna ktora nadpisujemy ma miec wartosc int to mozemy usunac wystapienia tej zmiennej z tablicy bool poniewaz w przyslosci
		--i tak nie wykorzystamy tych wartosci. Delete dziala w taki sposob ze jesli usuwanego elementu nie ma w tablicy to zwroci nie zmieniona tablice.
		--Czyli mozemy bezpiecznie usuwac "nie istniejace" wpisy w tablicy bool
		Left err -> Left err