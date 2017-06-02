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
  [--zwartko   
  Test "inc" (SrcString "input x in x + 1") (Eval [42] (Value 43)),
  Test "undefVar" (SrcString "x") TypeError,
  
  Test "singleVar" (SrcString "input x in x") (Eval [69] (Value 69)),
  Test "not" (SrcString "if not true then 2 else 1") (Eval [] (Value 1)),
  Test "not2" (SrcString "if not false then 2 else 1") (Eval [] (Value 2)),
  Test "neg" (SrcString "-3") (Eval [] (Value (-3))),
  Test "and" (SrcString "if true and true then 3 else 7") (Eval [] (Value 3)),
  Test "and2" (SrcString "if true and false then 3 else 7") (Eval [] (Value 7)),
  Test "and3" (SrcString "if false and true then 3 else 7") (Eval [] (Value 7)),
  Test "and4" (SrcString "if false and false then 3 else 7") (Eval [] (Value 7)),
  Test "or" (SrcString "if true or true then 3 else 7") (Eval [] (Value 3)),
  Test "or2" (SrcString "if true or false then 3 else 7") (Eval [] (Value 3)),
  Test "or3" (SrcString "if false or true then 3 else 7") (Eval [] (Value 3)),
  Test "or4" (SrcString "if false or false then 3 else 7") (Eval [] (Value 7)),
  Test "eq" (SrcString "if 1 = 1 then 1 else 4") (Eval [] (Value 1)),
  Test "eq2" (SrcString "if 1 = 4 then 1 else 4") (Eval [] (Value 4)),
  Test "nEq" (SrcString "if 1 <> 1 then 1 else 4") (Eval [] (Value 4)),
  Test "nEq2" (SrcString "if 1 <> 4 then 1 else 4") (Eval [] (Value 1)),
  Test "LT" (SrcString "if 1 < 4 then 1 else 4") (Eval [] (Value 1)),
  Test "LT2" (SrcString "if 1 < 1 then 1 else 4") (Eval [] (Value 4)),
  Test "LT3" (SrcString "if 1 < -4 then 1 else 4") (Eval [] (Value 4)),
  Test "GT" (SrcString "if 1 > -4 then 1 else 4") (Eval [] (Value 1)),
  Test "GT2" (SrcString "if 1 > 1 then 1 else 4") (Eval [] (Value 4)),
  Test "GT3" (SrcString "if 1 > 4 then 1 else 4") (Eval [] (Value 4)),
  Test "LE" (SrcString "if 1 <= 4 then 1 else 4") (Eval [] (Value 1)),
  Test "LE2" (SrcString "if 1 <= 1 then 1 else 4") (Eval [] (Value 1)),
  Test "LE3" (SrcString "if 1 <= -1 then 1 else 4") (Eval [] (Value 4)),
  Test "GE" (SrcString "if 1 >= 4 then 1 else 4") (Eval [] (Value 4)),
  Test "GE2" (SrcString "if 1 >= 1 then 1 else 4") (Eval [] (Value 1)),
  Test "GE3" (SrcString "if 1 >= -1 then 1 else 4") (Eval [] (Value 1)),
  Test "add" (SrcString "8 + 8") (Eval [] (Value 16)),
  Test "sub" (SrcString "8 - 8") (Eval [] (Value 0)),
  Test "mul" (SrcString "8 * 8") (Eval [] (Value 64)),
  Test "div" (SrcString "8 div 8") (Eval [] (Value 1)),
  Test "mod" (SrcString "37 mod 21") (Eval [] (Value 16)),
  Test "let" (SrcString "let x = 21 in x + 14") (Eval [] (Value 35)),
  
  Test "muchInput" (SrcString "input q w e r t y u i o p a s d f g h j k l z x c v b n m in h + a + s + k + e + l + l") (Eval [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7] (Value 38)),
  Test "abs" (SrcFile "abs.pp5") (Eval [37, 69] (Value 32)),
  Test "abs2" (SrcFile "abs.pp5") (Eval [69, 37] (Value 32)),
  Test "rectField" (SrcFile "rectField.pp5") (Eval [13, 37] (Value 481)),
  
  Test "tricky" (SrcString "if true then 21 else 37 div 0") (Eval [] (Value 21)),
  Test "tricky2" (SrcString "69 + -69") (Eval [] (Value 0)),
  Test "tricky3" (SrcString "- -1337") (Eval [] (Value 1337)),
  Test "tricky4" (SrcString "- - -1337") (Eval [] (Value (-1337))),
  Test "bool" (SrcString "if 13 = 37 and true then 13 else 37") (Eval [] (Value 37)),
  Test "bool2" (SrcString "if 13 = 37 or true then 13 else 37") (Eval [] (Value 13)),
  
  Test "const" (SrcString "2137") (Eval [] (Value 2137)),
  Test "nestedIf" (SrcString "if true then if true then 1 else 9 else 7") (Eval [] (Value 1)),
  Test "nestedLet" (SrcString "let x = 7 in let y = 9 in 1") (Eval [] (Value 1)),
  
  Test "numberAsBool" (SrcString "if 14 then 1997 else 88") TypeError,
  
  Test "numberAsBool2" (SrcString "if 8 and true then 3 else 4") TypeError,
  Test "numberAsBool3" (SrcString "if 7 or false then 3 else 4") TypeError,
  Test "boolAsNumber" (SrcString "true") TypeError,
  
  Test "foo" (SrcString "(1 div 0) + (2 + 1)") (Eval [] RuntimeError),
  
  -- here start new tests (added with lab5)
  
  Test "squareField" (SrcFile "squareField.pp5") (Eval [2] (Value 4)),
  Test "twoFunctions" (SrcFile "foo.pp5") (Eval [5] (Value 17)),
  Test "boolArg" (SrcFile "foo1.pp5") (Eval [9] (Value 7)),
  Test "boolArg2" (SrcFile "foo1.pp5") (Eval [1] (Value 6)),
  Test "boolFun" (SrcFile "foo2.pp5") (Eval [13] (Value 12)),
  Test "boolFun2" (SrcFile "foo2.pp5") (Eval [0] (Value 11)),
  Test "fib" (SrcFile "fib.pp5") (Eval [14] (Value 377)),
  Test "boolBool" (SrcFile "boolBool.pp5") (Eval [] (Value 16)),
  Test "boolBool2" (SrcFile "boolBool2.pp5") (Eval [] (Value 15)),
  Test "rec" (SrcFile "foo3.pp5") (Eval [17] (Value 17)),
  Test "composition" (SrcFile "composition.pp5") (Eval [20] (Value 57)),
  Test "pairArg" (SrcFile "foo4.pp5") (Eval [22, 23] (Value 22)),
  Test "pairArg2" (SrcFile "foo4.pp5") (Eval [2, 24] (Value 24)),
  Test "fooUnit" (SrcFile "fooUnit.pp5") (Eval [] (Value 25)),
  Test "pairArg3" (SrcFile "smaller.pp5") (Eval [26, 27] (Value 26)),
  Test "pairArg4" (SrcFile "smaller.pp5") (Eval [29, 28] (Value 28)),
  Test "pairArg5" (SrcFile "foo5.pp5") (Eval [30, 31] (Value 30)),
  Test "pairArg6" (SrcFile "foo6.pp5") (Eval [32, 33] (Value 33)),
  Test "sum" (SrcFile "sum.pp5") (Eval [] (Value 69)),
  Test "pairArg7" (SrcFile "foo7.pp5") (Eval [] (Value 36)),
  Test "fooUnit2" (SrcFile "fooUnit2.pp5") (Eval [] (Value 38)),
  Test "listArg" (SrcFile "foo8.pp5") (Eval [] (Value 39)),
  Test "listArg2" (SrcFile "foo9.pp5") (Eval [] (Value 0)),
  Test "listOfPairs" (SrcFile "foo10.pp5") (Eval [] (Value 44)),
  Test "pairOfLists" (SrcFile "foo11.pp5") (Eval [] (Value 48)),
  Test "fooList" (SrcFile "foo12.pp5") (Eval [] (Value 51)),
  
  Test "retBool" (SrcFile "bool.pp5") TypeError,
  Test "wrongArg" (SrcFile "foo13.pp5") TypeError,
  Test "wrongType" (SrcFile "foo14.pp5") TypeError,
  Test "wrongType2" (SrcFile "foo15.pp5") TypeError,
  Test "wrongType3" (SrcFile "foo16.pp5") TypeError,
  Test "wrongType4" (SrcFile "foo17.pp5") TypeError,
  Test "wrongType5" (SrcFile "foo18.pp5") TypeError,
  Test "wrongType6" (SrcString "fst [1,2] : int list") TypeError,
  Test "wrongType7" (SrcString "match (1, 2) with | [] -> 3 | x::xs -> 4") TypeError,


  --rudzicki
  Test "0inc"      (SrcString "input x in x + 1") (Eval [42] (Value 43))
  , Test "0undefVar" (SrcString "x")                TypeError
  , Test "easy0div"      (SrcString "input x in 1 div x") (Eval [0] RuntimeError)
  , Test "pairTest1"      (SrcString "input x in let y = (x,x) in fst y") (Eval [42] (Value 42))
  , Test "pairTest2"      (SrcString "input x in let y = (x,x) in snd y") (Eval [42] (Value 42))
  , Test "pairTestRTEfst"      (SrcString "input x in let y = (x,1 div x) in fst y") (Eval [0] RuntimeError)
  , Test "pairTestRTEsnd"      (SrcString "input x in let y = (x,1 div x) in snd y") (Eval [0] RuntimeError)
  , Test "pairTestTypeErr"      (SrcString "input x in let y = (x,true) in snd y") TypeError
  , Test "aloneUnit"      (SrcString "()") TypeError
  , Test "unitInPair"      (SrcString "input x in let y = (x,()) in fst y") (Eval [42] (Value 42))
  , Test "emptyList"      (SrcString "[]:int list") TypeError
  , Test "matchBranchEmpty"  (SrcString "let l = [] : int list in match l with [] -> 0 | x :: xs -> 1 div 0") (Eval [] (Value 0)) 
  , Test "matchBranchNotEmpty"  (SrcString "let l = [1] : int list in match l with [] -> 1 div 0 | x :: xs -> x") (Eval [] (Value 1)) 
  , Test "variadicArray"      (SrcString "match [1,()]:int list with [] -> 0 | x::xs ->1") TypeError
  , Test "fibNormal" (SrcFile "fib0.pp5") (Eval [6] (Value 8))
  , Test "fibZero" (SrcFile "fib0.pp5") (Eval [0] (Value 0))
  , Test "fib2X" (SrcFile "fib1.pp5") (Eval [0] (Value 0))
  , Test "fib2XAgain" (SrcFile "fib1.pp5") (Eval [6] (Value 16))
  , Test "sum1" (SrcFile "sum1.pp5") (Eval [0] (Value 0))
  , Test "sum2" (SrcFile "sum1.pp5") (Eval [5] (Value 5))
  , Test "bool1" (SrcFile "bool1.pp5") (Eval [42] (Value 42))
  , Test "bool2" (SrcFile "bool1.pp5") (Eval [666] (Value 666))
  , Test "bool3" (SrcFile "bool1.pp5") (Eval [7] RuntimeError)
  , Test "array1" (SrcFile "array.pp5") (Eval [0] (Value 0))
  , Test "array2" (SrcFile "array.pp5") (Eval [7] (Value 7))
  , Test "arraySum1" (SrcFile "arraySum.pp5") (Eval [0] (Value 0))
  , Test "arraySum2" (SrcFile "arraySum.pp5") (Eval [3] (Value 6))


  --wojcik
  ,Test "Inc" (SrcString "input x in x + 1") (Eval [42] (Value 43))
  , Test "UndefVar" (SrcString "x") TypeError
  , Test "AddBool"(SrcString "1 + false") TypeError 
  , Test "NegBool" (SrcString "if 1>0 then true else -true") TypeError 
  , Test "NotInt" (SrcString "if not 0 then 1 else 0") TypeError
  , Test "CompBool" (SrcString "if false < true then 1 else 0") TypeError
  , Test "OneAndOne" (SrcString "1 and 1") TypeError
  , Test "CompBool2" (SrcString "if true = true then 1 else 0") TypeError
  , Test "OtherIfTypes" (SrcString "if true then 1 else false") TypeError
  , Test "ReturnBool" (SrcString "2 > 1") TypeError
  , Test "ReturnBool2" (SrcString "1 = 1") TypeError
  , Test "ReturnBool3" (SrcString "if true then true else false") TypeError
  , Test "ReturnBool4" (SrcString "true") TypeError
  , Test "InvCond" (SrcString "if 1 then 1 else 0") TypeError
  , Test "AnswerToLife" (SrcString "42") (Eval [] (Value 42))
  , Test "TwoPlusTwo" (SrcString "2 + 2") (Eval [] (Value 4))
  , Test "Arith1" (SrcString "6 div 2 + 2 * 0") (Eval [] (Value 3))
  , Test "Arith2" (SrcString "5 mod 2") (Eval [] (Value 1))
  , Test "OpPrior" (SrcString "2 + 2 * 3") (Eval [] (Value 8))
  , Test "OpPrior2" (SrcString "7 + - 2") (Eval [] (Value 5))
  , Test "OpPrior3" (SrcString "if -1 * 3 = -1 + -2 * 1 then 1 else 0") (Eval [] (Value 1))
  , Test "DivBy0" (SrcString "5 div 0") (Eval [] RuntimeError)
  , Test "Mod0" (SrcString "1 mod 0") (Eval [] RuntimeError)
  , Test "TAndF" (SrcString "if true and false then 1 else 0") (Eval [] (Value 0))
  , Test "TOrF" (SrcString "if true or false then 1 else 0") (Eval [] (Value 1))
  , Test "InvCond2" (SrcString "if 1 = 1 or 3 > 2 mod 0 then 1 else 0") (Eval [] RuntimeError)
  , Test "Addition" (SrcString "input x y in x + y") (Eval [10,2] (Value 12))
  , Test "Subtraction" (SrcString "input x y in x - y") (Eval [10,-2] (Value 12))
  , Test "Multiplication" (SrcString "input x y in x * y") (Eval [-10,-2] (Value 20))
  , Test "Division" (SrcString "input x y in x div y") (Eval [5,2] (Value 2))
  , Test "CompTest" (SrcString "if 2 <> -2 and 5 >= 5 then 1 else 0") (Eval [] (Value 1))
  , Test "OpTest" (SrcString "if 7 div 2 = 6 div 2 then 1 else 0") (Eval [] (Value 1))
  , Test "OneValidIf" (SrcString "if true and true then 4 div 0 else 1") (Eval [] RuntimeError)
  , Test "OneValidIf2" (SrcString "if false or false then 4 div 0 else 1") (Eval [] (Value 1))
  , Test "Constant" (SrcString "input x in 10") (Eval [4] (Value 10))
  , Test "Abs" (SrcString "input x in if x < 0 then -x else x") (Eval [-2] (Value 2))
  , Test "Abs2" (SrcString "input x in if x < 0 then -x else x") (Eval [2] (Value 2))
  , Test "Id" (SrcString "input x in let a = not true in if a then 0 else x") (Eval [4573218] (Value 4573218))
  , Test "NestedLet" (SrcString "let x = 1 in let x = x in x") (Eval [] (Value 1))
  -- Prac5
  , Test "IncompleteNil" (SrcString "let x = [] : int in if true then 1 else 0") TypeError
  , Test "WrongArgument" (SrcFile "wrarg.pp5") TypeError
  , Test "Id2" (SrcFile "id2.pp5") (Eval [3274] (Value 3274))
  , Test "FstTest" (SrcString "fst (1, 2)") (Eval [] (Value 1))
  , Test "SndTest" (SrcString "snd (1, 2)") (Eval [] (Value 2))
  , Test "DivInPair" (SrcString "fst (2, 3 div 0)") (Eval [] RuntimeError)
  , Test "PairTest" (SrcString "let z = (5, 1) in if true then fst z else snd z") (Eval [] (Value 5))
  , Test "TwoTypesList" (SrcString "let x = [1, true, 2] : int list in if true then 1 else 0") TypeError
  , Test "InvCons1" (SrcString "let y = [1, 2] : int list in let x = true::y in if true then 1 else 0") TypeError
  , Test "InvCons2" (SrcString "let x = [] : bool list in let y = 1::x in if true then 1 else 0") TypeError
  , Test "MatchNonList" (SrcString "let a = (1, 2) in match a with [] -> 1 | x::xs -> 0") TypeError
  , Test "Factorial" (SrcFile "factorial.pp5") (Eval [5] (Value 120))
  , Test "UnitTest" (SrcFile "foo_unit.pp5") (Eval [] (Value 2))
  , Test "LastOfList" (SrcFile "list_last.pp5") (Eval [] (Value 3))

   ,Test "inc"      (SrcString "input x in x + 1") (Eval [42] (Value 43))
  , Test "undefVar" (SrcString "x")                TypeError
  , Test "hidingVariablesCorrect" (SrcString "let x = true in let x = 5 in x + 5") (Eval [] (Value 10))
  , Test "hidingVariablesIncorrect" (SrcString "let x = 5 in let x = true in x + 5") TypeError
  , Test "unaryOperator1" (SrcString "-true") TypeError
  , Test "unaryOperator2" (SrcString "not 1") TypeError
  , Test "binaryOperator1" (SrcString "true + 1") TypeError
  , Test "binaryOperator2" (SrcString "2 and false") TypeError
  , Test "binaryOperator3" (SrcString "true mod false") TypeError
  , Test "binaryOperator4" (SrcString "2 < 3") TypeError
  , Test "ifConditionInt" (SrcString "if 2 + 3 then 1 else 0") TypeError
  , Test "ifTypeMismatch" (SrcString "if 2 > 0 then 1 else false") TypeError
  , Test "orRunError" (SrcString "if false or 5 div 0 = 3 then 1 else 0") (Eval [] RuntimeError)
  , Test "runErrorAgain" (SrcString "10 mod (3 * 5 - 15)") (Eval [] RuntimeError)
  , Test "allWorksFine" (SrcString "input x y in if x * 5 - y > 0 or false then let k = x <> 3 in (x + y) mod 5 div 2 + 5 * 13 else x div 0") (Eval [10, 5] (Value 65))
  , Test "fibonacci" (SrcFile "fib.pp5") (Eval [10] (Value 55))
  , Test "mergesort" (SrcFile "mergesort.pp5") (Eval [3, 1, 5, 2, 4] (Value 55))
  , Test "emptyListTypeError" (SrcString "let x = [] : int in 1") TypeError
  , Test "loop1" (SrcFile "loop.pp5") (Eval [1] RuntimeError)
  , Test "loop2" (SrcFile "loop.pp5") (Eval [2] RuntimeError)
  , Test "modulo1" (SrcFile "modulo.pp5") (Eval [6, 1] (Value 4))
  , Test "modulo2" (SrcFile "modulo.pp5") (Eval [6, 0] RuntimeError)
  , Test "modulo3" (SrcFile "modulo.pp5") (Eval [5, 6] RuntimeError)
  , Test "modulo4" (SrcFile "modulo.pp5") (Eval [5, 5] (Value 0))
  , Test "errorCheck1" (SrcString "fst (1, 2 div 0)") (Eval [] RuntimeError)
  , Test "errorCheck2" (SrcString "fun f (x:int):int = 0 input x in f (x div 0)") (Eval [1] RuntimeError)
  , Test "functionVariableCollision" (SrcString "fun f (x:int) : int = x + 1 input f in f f") (Eval [5] (Value 6))
  , Test "returnTypeError" (SrcString "fun f (x:int) : bool = x + 1 input x in x") TypeError
  , Test "listTypeError" (SrcString "let l = (2 + 2 = 4) :: [] : int list in 5") TypeError
  , Test "matchTypeError1" (SrcString "match 10 with [] -> 1 | h::t -> 2") TypeError
  , Test "matchTypeError2" (SrcString "match [10] : int list with [] -> 5 | h::t -> t") TypeError

  ]