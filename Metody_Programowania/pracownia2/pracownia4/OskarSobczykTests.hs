-- Wymagamy, by moduł zawierał tylko bezpieczne funkcje
{-# LANGUAGE Safe #-}
-- Definiujemy moduł zawierający testy.
-- Należy zmienić nazwę modułu na {Imie}{Nazwisko}Tests gdzie za {Imie}
-- i {Nazwisko} należy podstawić odpowiednio swoje imię i nazwisko
-- zaczynające się wielką literą oraz bez znaków diakrytycznych.
module OskarSobczykTests(tests) where

-- Importujemy moduł zawierający typy danych potrzebne w zadaniu
import DataTypes

-- Lista testów do zadania
-- Należy uzupełnić jej definicję swoimi testami
tests :: [Test]

tests = [ Test "undefVar" (SrcString "x") TypeError
  , Test "zlyTypOperacji1" (SrcString "true*1") TypeError
  , Test "zlyTypOperacji2" (SrcString "false*1") TypeError
  , Test "zlyTypOperacji3" (SrcString "1*true") TypeError
  , Test "zlyTypOperacji4" (SrcString "1*false") TypeError
  , Test "zlyTypOperacji5" (SrcString "true + false") TypeError
  , Test "zlyTypOperacji6" (SrcString "true mod false") TypeError
  , Test "zlyTypOperacji7" (SrcString "true div false") TypeError
  , Test "zlyTypOperacji8" (SrcString "0 div false") TypeError
  , Test "zlyTypOperacji9" (SrcString "0 mod false") TypeError
  , Test "zlyTypOperacji10" (SrcString "false div 5") TypeError
  , Test "zlyTypOperacji11" (SrcString "true mod 5") TypeError

  , Test "zlyTypUnarny1" (SrcString "-true") TypeError
  , Test "zlyTypUnarny2" (SrcString "-false") TypeError
  , Test "zleNegowanie1" (SrcString "not 5") TypeError

  , Test "if1" (SrcString "if true then false else false") TypeError
  , Test "if2" (SrcString "if true then 1 else false") TypeError
  , Test "if3" (SrcString "if 5 then 1 else 1") TypeError
  , Test "if4" (SrcString "if true then false else 3") TypeError

  , Test "or1" (SrcString "3 or 5") TypeError
  , Test "or2" (SrcString "3 or false") TypeError
  , Test "or3" (SrcString "true or 2") TypeError

  , Test "and1" (SrcString "3 and 5") TypeError
  , Test "and2" (SrcString "3 and false") TypeError
  , Test "and3" (SrcString "true and 2") TypeError

  , Test "eq1" (SrcString "true > false") TypeError
  , Test "eq2" (SrcString "true > 0") TypeError
  , Test "eq3" (SrcString "true = false") TypeError
  , Test "eq4" (SrcString "true > false") TypeError
  , Test "eq5" (SrcString "true > 0") TypeError
  , Test "eq6" (SrcString "true <> false") TypeError
  , Test "eq7" (SrcString "true < 0") TypeError
  , Test "eq8" (SrcString "true < false") TypeError
  , Test "eq9" (SrcString "true <= false") TypeError
  , Test "eq10" (SrcString "true >= 0") TypeError


  , Test "let1" (SrcString "let x = true in false") TypeError
  , Test "let1" (SrcString "let x = 5 in false") TypeError
  , Test "let2" (SrcString "input x in let x = 3 in true+x") TypeError
  , Test "let3" (SrcString "input x in let x = 4 in true+false") TypeError
  , Test "let4" (SrcString "input x in let x = true in 4+x") TypeError]
{-|
tests =
  [ Test "inc"      (SrcString "input x in x + 1") (Eval [42] (Value 43))
  , Test "undefVar" (SrcString "x")                TypeError
  , Test "typeError1" (SrcString "not 2") TypeError
  , Test "typeError2" (SrcString "- true") TypeError
  , Test "typeError3" (SrcString "true * 7") TypeError
  , Test "nodefvar" (SrcString "input a in a + b") TypeError
  ,Test "simple" (SrcString "1+1") (Eval [] (Value 2))
  ,Test "simple2" (SrcString "1-1") (Eval [] (Value 0))
  ,Test "mult" (SrcString "input a b in a * b") (Eval [2,3] (Value 6))
  ,Test "multminus" (SrcString "input a b in a * b") (Eval [(-2),3] (Value (-6)))
  ,Test "noint" (SrcString "true") TypeError
  ,Test "divByZero" (SrcString "2 div 0") (Eval [] (RuntimeError))
  ,Test "if1" (SrcString "input x in if x < 2 then x + x else x + 1") (Eval[1] (Value 2))
  ,Test "if2" (SrcString "input x in if x < 2 then x + x else x + 1") (Eval[3] (Value 4))
  ,Test "badif" (SrcString "input x in if x < 2 then x + x else x div 0") (Eval[3] (RuntimeError))
  ,Test "typebadif" (SrcString "input x in if 1 then x else x * x") TypeError
  ,Test "ifor" (SrcString "input x y in if x < 1 or y > 1 then x + y else x - y") (Eval[0,1] (Value 1))
  ,Test "ifand" (SrcString "input x y in if x < 1 and y > 1 then x + y else x - y") (Eval[0,1] (Value (-1)))
  ,Test "let" (SrcString "input a b in let x = a + b + 1 in x + a + b") (Eval[2,3] (Value 11))
  ,Test "ifinif" (SrcString "input a b in if a > 0 then if b = 0 then a + b else a else b") (Eval[1,0] (Value 1))
  ]
-}