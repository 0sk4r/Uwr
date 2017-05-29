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
-- Należy uzupełnić jej definicję swoimi testami
tests :: [Test]
tests =
  [ Test "inc"      (SrcString "input x in x + 1") (Eval [42] (Value 43))
  , Test "undefVar" (SrcString "x")                TypeError
  , Test "simple_pair" (SrcString "fst (1,true)") (Eval [] (Value 1))
  , Test "wrong_pair" (SrcString "snd (2,true)") TypeError
  , Test "program_return_int_pair" (SrcString "(1,2)") TypeError
  , Test "wrong_var_dec_function" (SrcFile "wrong_var_dec_function.pp5") TypeError
  , Test "simple_function_int" (SrcFile "simple_function_int.pp5") (Eval [1] (Value 2))
  , Test "simple_function_bool" (SrcFile "simple_function_bool.pp5") (Eval [] (Value 1))
  , Test "wrong_freturn" (SrcFile "wrong_freturn.pp5") TypeError
  , Test "function_take_list" (SrcFile "function_take_list.pp5") (Eval [] (Value 2))
  --, Test "function_return_pair" (SrcFile "ret_pair.pp5") (Eval [1] (Value 2))
  , Test "plus_function" (SrcFile "plus_function.pp5") (Eval [] (Value 3))
  , Test "fib" (SrcFile "fib.pp5") (Eval [3] (Value 2))
  , Test "fun_in_fun" (SrcFile "funinfun.pp5") TypeError
  , Test "let" (SrcFile "funinfun.pp5") (Eval [] (Value 3))
  , Test "let_in_let" (SrcFile "let_in_let.pp5") (Eval [] (Value 3))
  , Test "div_by_zero" (SrcFile "div_by_zero.pp5") (Eval [] RuntimeError)
  , Test "sum" (SrcFile "sum.pp5") (Eval [1,2,3,4] (Value 4))
  ]