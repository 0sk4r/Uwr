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
