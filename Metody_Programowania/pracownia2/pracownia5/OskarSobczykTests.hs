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
  , Test "function_take_list" (SrcFile "function_take_list.pp5") (Eval [] (Value 3))
  --, Test "function_return_pair" (SrcFile "ret_pair.pp5") (Eval [1] (Value 2))
  , Test "plus_function" (SrcFile "plus_function.pp5") (Eval [] (Value 3))
  , Test "fib" (SrcFile "fib.pp5") (Eval [3] (Value 2))
  , Test "fun_in_fun" (SrcFile "funinfun.pp5") (Eval [] (Value 1))
  , Test "let" (SrcFile "funinfun.pp5") (Eval [] (Value 1))
  , Test "let_in_let" (SrcFile "let_in_let.pp5") (Eval [] (Value 3))
  , Test "div_by_zero" (SrcFile "div_by_zero.pp5") (Eval [] RuntimeError)
  , Test "sum" (SrcFile "sum.pp5") (Eval [1,2,3,4] (Value 3))



  ,Test "inc"      (SrcString "input x in x + 1") (Eval [42] (Value 43))
  , Test "undefVar" (SrcString "x")                TypeError
  , Test "old_ghost" (SrcString "let y = (false or 5 = (5 div 0)) in 1") (Eval [] RuntimeError)
  , Test "simple_typeError" (SrcString "2 + true") TypeError
  , Test "old_laziness" (SrcString "let x = true in if x then 0 else 1 div 0") (Eval [] (Value 0))
  , Test "new_laziness_of_list_matching" (SrcString "let x = [1,2,3]:int list in match x with [] -> 1 div 0 | y :: ys -> y") (Eval [] (Value 1))
  , Test "empty_list_laziness" (SrcString "let x = []:int list in match x with [] -> 0 | y :: ys -> y div 0") (Eval [] (Value 0))
  , Test "list_matching" (SrcString "let x = [51,2,3]: int list in match x with [] -> 0 | y :: ys -> y") (Eval [] (Value 51))
  , Test "empty_list_matching" (SrcString "let li = [] : int list in match li with [] -> 21 | x :: xs -> x") (Eval [] (Value 21))
  , Test "function_application" (SrcString "fun add5(x : int) : int = x + 5 input a in let a = 10 in add5(a)") (Eval [1] (Value 15))
  , Test "list_constructor" (SrcString "let x = 25 in let y = [1,2,3,4]:int list in let a = x :: y in match a with [] -> 0 | b :: bs -> b") (Eval [] (Value 25))
  , Test "bool_list_constructor" (SrcString "let x = true in let y = [true,false,true] : bool list in let a = x :: y in match a with [] -> 1 | b :: bs -> if b then 2 else 0") (Eval [] (Value 2))
  , Test "wrong_types_in_list_constructor" (SrcString "let x = [1,2] : int list in let y = [3] : int list in let a = x :: y in match a with [] -> 1 | b :: bs -> 2") TypeError
  , Test "trickier_list_construction" (SrcString "let x = (true, (true, 2)) in let y = [3] : int list in let a = (snd (snd x)) :: y in match a with [] -> 1 | b :: bs -> 2") (Eval [] (Value 2))
  , Test "wrong_types_again" (SrcString "let x = (true, (true, 2)) in let y = [3] : int list in let a = (snd (fst x)) :: y in match a with [] -> 1 | b :: bs -> 2") TypeError
  , Test "projection_test" (SrcString "input a in let x = (a+2,a) in fst x") (Eval [7] (Value 9))
  , Test "snd_projection_test" (SrcString "input a in let x = (a+2, a+4) in snd x") (Eval [5] (Value 9))
  , Test "non_trivial_projection" (SrcString "input a in let x = (a div 0, a) in snd x") (Eval [5] RuntimeError)
  , Test "projection_in_if" (SrcString "let x = (true, 5) in if not fst x then (snd x) div 0 else snd x") (Eval [] (Value 5))
  , Test "projection_wrong_type" (SrcString "let x = (5, true) in if fst x then ( if snd x then 1 else 0 ) else (if snd x then 2 else 3)") TypeError
  , Test "int_list-int_mistake" (SrcString "let x = [1,2,3]:int in 1") TypeError
  , Test "int_list_int_mistake2" (SrcString "let x = [[1]:int list]: int list in 1") TypeError
  , Test "factorial_with_accumulator" (SrcFile "factorial.pp5") (Eval [] (Value 1))
  , Test "sum_of_ackermanns" (SrcFile "ackermann.pp5") (Eval [2] (Value 42))
  , Test "map_and_list" (SrcFile "map.pp5") (Eval [2] (Value 100))
  , Test "length_test" (SrcFile "length.pp5") (Eval [10] (Value 15))
  , Test "zero_division_in_unused_function" (SrcFile "absolute.pp5") (Eval [-2,2,-4] (Value 8))
  , Test "sometimes_zero_div" (SrcFile "thendivzero.pp5") (Eval [2] RuntimeError)
  , Test "and_sometimes_not" (SrcFile "thendivzero.pp5") (Eval [-2] (Value 2))
  , Test "wrong_type_of_argument" (SrcFile "wrongargument.pp5") TypeError
  , Test "some_exponents" (SrcFile "power.pp5") (Eval [2,10] (Value 1024))
  , Test "nested_list" (SrcString "let x = [[1,2] :int list, [3,4]:int list, [5,6]: int list]: int list list in 1") (Eval [] (Value 1))
  , Test "double_variable_bool_list" (SrcString "input x in let x = true in match [true,true,x] : bool list with [] -> 0 | t :: ts -> if not t then 2 else 3") (Eval [2] (Value 3))
  , Test "a_lot_of_nesting" (SrcString "let x = [[[1]: int list ]: int list list ] : int list list list in let y = []: int list list list list in let a = x :: y in 1 ") (Eval [] (Value 1))
  , Test "not_enough_nested" (SrcString "let x = [[[1]: int list ]: int list list ] : int list list list in let y = []: int list list list in let a = x :: y in 1 ") TypeError
  , Test "function_passing" (SrcFile "function_calling.pp5") (Eval [] (Value 1))
  , Test "typecheck_of_unused_function" (SrcFile "unused_fun.pp5") TypeError
  , Test "wrong_return_type" (SrcFile "wrong_return_type.pp5") TypeError 
  , Test "well_typed_but_without_sense" (SrcString "42 + []:int") TypeError
  , Test "global_variables" (SrcString "fun wrong(a:int):int = b input b in wrong(b)") TypeError
  , Test "local_variables" (SrcString "fun wrong(a:int):int = 1 input x in a") TypeError
  ]