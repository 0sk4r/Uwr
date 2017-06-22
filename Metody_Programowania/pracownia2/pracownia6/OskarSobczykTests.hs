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
  [ Test "anon_func" (SrcString "let x=10 in (fn(y:int)-> x+y) 5") (Eval [] (Value 15))
  , Test "wrong_anon_func" (SrcString "let x=17 in (fn(y:int)-> x*y) ") TypeError
  , Test "if-with-lambda" (SrcString "fun g(a:int):int = a+5 input b in if b<5 then g b else let d=fn(c:int) -> g(c)+1 in d b") (Eval[11] (Value 17))
  , Test "function-return-funtion" (SrcString "fun foo(u:unit):int->int = fn (x:int)-> x+10 input d in foo() d") (Eval[5] (Value 15))
  , Test "func-but-var" (SrcString "fun f(x : int): int = x input x in let f = x in f f") TypeError
  , Test "lambda-in-let" (SrcString "let y = 10 in let foo = fn(x:int) -> x+y in foo 20") (Eval[] (Value 30))
  , Test "nested-lambda" (SrcString "fun foo(x:int):int = x - 3 input y in let x = fn(b:int) -> foo(b)+2 in x y") (Eval[5] (Value 4))
  , Test "if-function" (SrcString "fun g(a:int):int = a+10 input b in if b<10 then g b else let d=fn(c:int) -> g(c)+5 in d b") (Eval[3] (Value 13))
  , Test "bool-lambda" (SrcString "input x in let y = if x > 0 then true else false in let foo = fn(y:bool) -> not y in if foo y then 100 else 111") (Eval[(-1)] (Value 100))
  , Test "function-take-function" (SrcString "fun foo(bar:int->int): int = bar(5) in let x = fn(x:int) -> x+5 in foo(x)") (Eval[] (Value 10))
  , Test "var-over-func" (SrcString "fun f(x : int): int = x input x in let f = x in f") (Eval[34] (Value 34))
  , Test "test" (SrcString "input x y in let x = fn(a:int)-> a+1 in x y") (Eval [5,3] (Value 4))
  , Test "typerror-in-lambda" (SrcString "let x = fn(a:bool)->a+2 in x(true)") TypeError
  , Test "RuntimeError-in-lambda" (SrcString "let x = fn(a:int)->2 div a in x(0)") (Eval [] RuntimeError)
  ]