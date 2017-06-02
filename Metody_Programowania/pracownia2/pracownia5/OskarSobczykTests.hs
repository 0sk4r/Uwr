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
  , Test "IncompleteNil" (SrcString "let x = [] : int in if true then 1 else 0") TypeError
  , Test "pairArg" (SrcFile "foo4.pp5") (Eval [22, 23] (Value 23)) --czy testy ze zlymi odp
  , Test "pairArg2" (SrcFile "foo4.pp5") (Eval [2, 24] (Value 2))
  , Test "listOfPairs" (SrcFile "foo10.pp5") (Eval [] (Value 0))
  , Test "fooList" (SrcFile "foo12.pp5") (Eval [] (Value 51)),

  --dobre
  Test "retBool" (SrcFile "bool.pp5") TypeError,
  Test "wrongArg" (SrcFile "foo13.pp5") TypeError,
  Test "wrongType" (SrcFile "foo14.pp5") TypeError,
  Test "wrongType2" (SrcFile "foo15.pp5") TypeError,
  Test "wrongType3" (SrcFile "foo16.pp5") TypeError,
  Test "wrongType4" (SrcFile "foo17.pp5") TypeError,
  Test "wrongType5" (SrcFile "foo18.pp5") TypeError,
  Test "wrongType6" (SrcString "fst [1,2] : int list") TypeError,
  Test "wrongType7" (SrcString "match (1, 2) with | [] -> 3 | x::xs -> 4") TypeError
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
  , Test "local_variables" (SrcString "fun wrong(a:int):int = 1 input x in a") TypeError,


  Test "I'm Still Standing"     (SrcString "input x in x + (let a = false in a)") TypeError,
  Test "Nikita" (SrcString "x")         TypeError,       
  Test "Your Song"(SrcString "input x y in (x or y) and false")          TypeError,
  Test "Rocket Man" (SrcString "input x in if x > 5 then true else 5")   TypeError,
  Test "Crocodile Rock" (SrcString "input x in if x > a then true else 5")  TypeError,
  Test "Daniel" (SrcString "false") TypeError,
  Test "Goodbye Yellow Brick Road" (SrcString "input a b in if a <> b then let a = 4 + 1  in a + 2 else let b = false in b or (a < 2) " ) TypeError,
  Test "Don't Let The Sun Go Down On Me" (SrcString "let the_sun = 5 in let b = the_sun > 2 in the_sun mod b" ) TypeError,
  Test "Sorry Seems To Be The Hardest Word" (SrcString "let a = 5 in let b = a > 2 in a and b" ) TypeError,
  Test "The Last Song"  (SrcString "if The then Last else Song " ) TypeError,
  Test "Sacrifice"  (SrcString "5 + 5 or 2 > 3 and false " ) TypeError,
  Test "Circle Of Life" (SrcString "5 + 2 * (42 - (12 mod (23 div a)) )" ) TypeError,
  Test "Candle In the Wind" (SrcString "5 + 2 * (42 - (12 mod (23 div false)) )" ) TypeError,
  Test "Can You Feel The Love Tonight?" (SrcString "let e = false in let j = true in e and (j or (a and (e or (false and 1)))) " ) TypeError,
  
  
  Test "Tubular Bells" (SrcString "input x in let y = 3 in if x * 2 >= 100 and x * y <= 150 then 4 else 5 * y") (Eval [50] (Value 4)),
  Test "Tubular Bells II" (SrcString "input x in let y = 3 in if x * 2 >= 100 and x * y <= 150 then 4 else 5 * y") (Eval [44] (Value 15)),
  Test "Tubular Bells III" (SrcString "let y = 3 in y * y div y div y") (Eval [] (Value 1)),
  Test "Voyager" (SrcString "input x in x + 1") (Eval [42] (Value 43)),
  Test "QE2" (SrcString "input x in if x >= 0 then x else -x") (Eval [-5] (Value 5)),
  Test "Five Miles Out" (SrcString "input x in if x >= 0 then x else -x") (Eval [42] (Value 42)),
  Test "Crises" (SrcString "input x in if x >= 0 then x else -x") (Eval [0] (Value 0)),
  Test "Ommadawn" (SrcString "input x in if x mod 2 = 0 then  x * x - 3 * x + 7 else x mod 17 + 3") (Eval [1975] (Value 6)),
  Test "Return to Ommadawn" (SrcString "input x in if x mod 2 <> 0 then  x * x - 3 * x + 7 else x mod 17 + 3") (Eval [2017] (Value 4062245)),
  Test "The Songs Of Distant Earth" (SrcString "input x in if x mod 2 = 0 then x mod 50 else x div 0") (Eval [1994] (Value 44)),
  Test "Guitars" (SrcString "input x in if x mod 2 = 0 then x mod 50 else x div 0") (Eval [1999] RuntimeError),
  Test "Man On The Rocks" (SrcString "input x  y z in let a = 2 in let b = 3 in let c = 4 in let p = true in if p then x + y + z - a + b * c else -12") (Eval [2014, 3, 3] (Value 2030)),
  Test "Tubular Bells 2003"  (SrcString "if 2003 > 42 and 2003 < 4540 then 53 else 8 mod 0") (Eval [] (Value 53)),
  Test "Heaven's Open"  (SrcString "input x in let x = 44 in let x = 2 in let x = 32 in x") (Eval [22] (Value 32)),
  
  
  Test "Another Brick In The Wall" (SrcString "fun const(x:int) : int = 2  input x in if const x then 1 else 0")  TypeError,
  Test "Hey You" (SrcString "fun const(x:int) : int = false  input x in if const x then 1 else 0")  TypeError,
  Test "Mother" (SrcString "fun f(x:bool) : int = if x then 1 else 0  input x in f x") TypeError,
  Test "Young Lust" (SrcString "fun f(x:bool) : int = if x then 1 else false  input x in f (x > 0)") TypeError,
  Test "Comfortably Numb" (SrcString "fst (true, false) + 1") TypeError, 
  Test "In The Flesh" (SrcString "snd (1, 2) + true ") TypeError, 
  Test "One Slip" (SrcString "fun head(l : int list) : int = match l with  [] -> 0 | x :: xs -> x input x in head [true, false] : bool list") TypeError,
  Test "Terminal Frost" (SrcString "fun f(x : int ) : bool = x > 2 input x in snd (f x, f (x - 2))") TypeError,
  Test "High Hopes" (SrcString "fun fib(n : int) : bool = if n <= 1 then n else fib(n-1) + fib(n-2) input n in fib(n)") TypeError,
  Test "Marooned"  (SrcString  "fun f (n : bool) : int list = [1,2,3] : int list  input x  in f (x > 5)") TypeError,
  Test "Wearing The Inside Out" (SrcString "fun p (n : int) : int * int = (n, n) input n in p n") TypeError,
  Test "Echoes"  (SrcString "fst (1, 2)") (Eval [] (Value 1)),
  Test "Wish You Were Here"  (SrcString "snd (1, 2)") (Eval [] (Value 2)),
  Test "Shine On You Crazy Diamond" (SrcString "fun fib(n : int) : int = if n <= 1 then n else fib(n-1) + fib(n-2) input n in fib(n)") (Eval [0] (Value 0)),
  Test "Time" (SrcString "fun fib(n : int) : int = if n <= 1 then n else fib(n-1) + fib(n-2) input n in fib(n)") (Eval [1] (Value 1)),
  Test "Money" (SrcString "fun fib(n : int) : int = if n <= 1 then n else fib(n-1) + fib(n-2) input n in fib(n)") (Eval [2] (Value 1)),
  Test "Us And Them" (SrcString "fun fib(n : int) : int = if n <= 1 then n else fib(n-1) + fib(n-2) input n in fib(n)") (Eval [19] (Value 4181)),
  Test "Lost For Words" (SrcString "fun p (n : int) : int * int = (n, n) input n in fst (p n)") (Eval [1] (Value 1)),
  Test "Breathe (In The Air)" (SrcString "fun p (n : int) : int * int = (n, n) input n in snd (p n)") (Eval [42] (Value 42)),
  Test "Cluster One" (SrcString "fun head(l : int list) : int = match l with  [] -> 0 | x :: xs -> x input x in head [2, x] : int list") (Eval [42] (Value 2)),
  Test "One Of These Days" (SrcString "fun head(l : int list) : int = match l with  [] -> 0 | x :: xs -> x input x in head [4, 2] : int list") (Eval [42] (Value 4)),
  Test "Dogs" (SrcString "fun head(l : int list) : int = match l with  [] -> 0 | x :: xs -> x input x in head [x , x, x] : int list") (Eval [42] (Value 42)),
  Test "Sheep" (SrcString "fun head(l : int list) : int = match l with  [] -> 0 | x :: xs -> x input x in head [] : int list") (Eval [42] (Value 0))
  

  , Test "undefVar" (SrcString "x")                TypeError
  , Test "smplTest1" (SrcString "2")               (Eval [] (Value 2))
  , Test "smplTest2" (SrcString "-2 + 2")          (Eval [] (Value 0))
  , Test "smplTest3" (SrcString "-2 div 0")          (Eval [] RuntimeError)
  , Test "smplTest4" (SrcString "1 - 2 + 3")       (Eval [] (Value 2))
  , Test "smplTest5" (SrcString "1 div 2")         (Eval [] (Value 0))
  , Test "smplTest6" (SrcString "14 mod 10")       (Eval [] (Value 4))
  , Test "smplTest7" (SrcString "11 mod 10 * 10")  (Eval [] (Value 10))
  , Test "smplTypeTest8" (SrcString "2 + true")        TypeError
  , Test "smplTypeTest9" (SrcString "input x in if 5 then false else x")
                                                   TypeError

  , Test "smplTypeTest10" (SrcString "input x in x + y")
                                                   TypeError

  , Test "smplLet11" (SrcString "input z y in let x = z + y in x")
                                                   (Eval [2, 3] (Value 5))

  , Test "smplTypeLet11" (SrcString "input z in let x = z + y in x")
                                                   TypeError

  , Test "smplTypeIf12" (SrcString "input x y in if x = y then x else false")
                                                   TypeError

  , Test "smplIf13" (SrcString "input x z y in if x = z + y then x else z")
                                                   (Eval [5, 3, 2] (Value 5))

  , Test "smplIf14" (SrcString "input x z y in if x = z + y then x else z")
                                                   (Eval [6, 3, 2] (Value 3))

  , Test "smplIf15" (SrcString "if true then 42 else 1 div 0")
                                                   (Eval [] (Value 42))

  , Test "smplTest16" (SrcString "42 mod 0")       (Eval [] RuntimeError)

  , Test "override"
             (SrcString "input x in let x = x + 1 in let x = x + 2 in x")
                                                   (Eval [39] (Value 42))

  , Test "smplTest18" (SrcString
                "if 4 > 2 then if true or false then 2 else 0 else 1")
                                                   (Eval [] (Value 2))

  , Test "smplTest19" (SrcString "if true and false then 0 else 1")
                                                   (Eval [] (Value 1))

  , Test "smplTest20"
                (SrcString "if 2 <> 1 and 3>=3 and 2=2 then 1 else 0")
                                                   (Eval [] (Value 1))

  , Test "prioBool21"
                 (SrcString "if true or false and true then 1 else 0")
                                                   (Eval [] (Value 1))

  , Test "smplTypeTest22" (SrcString "let x = 2 < 1 in x")
                                                   TypeError
  -- koniec testow z poprzedniej pracowni


  --testy nowych elementow jezyka
  , Test "smplFun" (SrcString "fun f(x : int) : int = 1 in f(1)")
                                                   (Eval [] (Value 1))
  , Test "smplfst" (SrcString "fst (1, true)")
                                                   (Eval [] (Value 1))
  , Test "smplsndTE" (SrcString "snd (1, true)")
                                                    TypeError
  , Test "smplFunWUnit" (SrcString "fun f(x : unit) : int = 1 in f()")
                                                   (Eval [] (Value 1))
  , Test "smplFunWUnit1" (SrcString "let x = (1, 2) in fst x")
                                                   (Eval [] (Value 1))
  , Test "weirdList" (SrcString "let x = [2+2, if true then 1 else 2]:int list in 1")
                                                   (Eval [] (Value 1))
  , Test "smplFun2" (SrcString "fun suma(x:int*int):int = fst x + snd x in suma(2,3)")
                                                   (Eval [] (Value 5))
  , Test "notfuninenv" (SrcString "f(2)")
                                                    TypeError
  , Test "notfuninenv1" (SrcString "fun f(x:int):int = 0 in ff(2)")
                                                    TypeError
  , Test "returnTyEr1" (SrcString "fun f(x:int):bool = true in 1 + f(2)")
                                                    TypeError
  , Test "returnTyEr" (SrcString "fun f(x:int):int = true in 0")
                                                    TypeError
  , Test "summatch"  (SrcFile "t2.pp5") (Eval [] (Value 9))
  , Test "filunit"  (SrcFile "t3.pp5") (Eval [] (Value 0))
  , Test "funfst"  (SrcFile "t4.pp5") (Eval [] (Value 2))
  , Test "fstlist"  (SrcFile "t5.pp5") (Eval [] (Value 2))
  , Test "consTest"  (SrcFile "t6.pp5") (Eval [] (Value 42))
  , Test "argTyEr"  (SrcFile "t7.pp5") TypeError
  , Test "consTyEr"  (SrcFile "t8.pp5") TypeError
  , Test "matchinmatch"  (SrcFile "t9.pp5") (Eval [] (Value 2))
  , Test "typeErrinMatch"  (SrcFile "t10.pp5") TypeError
  , Test "leftEvaluation"  (SrcString ("fun nearlyLoop(u: unit):int = 1 div 0 + nearlyLoop()"
                                  ++"in nearlyLoop()"))
                                                              (Eval [] RuntimeError)
  , Test "testsFunEnv"  (SrcFile "t11.pp5") (Eval [] (Value 42))
  , Test "consTest"  (SrcFile "t12.pp5") (Eval [] (Value 42))
  , Test "tyErrMatch"  (SrcFile "t13.pp5") TypeError
  , Test "match33" (SrcString "match [4,2,3]: int list with [] -> 1 div 0 | x::xs -> x") (Eval [] (Value 4))
  , Test "listwithpairs"  (SrcFile "t14.pp5") (Eval [] (Value 223))
  , Test "rerrOnIf"  (SrcFile "t15.pp5") (Eval [] RuntimeError)
  , Test "paitsinif"  (SrcFile "t16.pp5") (Eval [] (Value 44))




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
  , Test "array1" (SrcFile "array.pp5") (Eval [0] (Value 0))
  , Test "array2" (SrcFile "array.pp5") (Eval [7] (Value 7))
  , Test "arraySum1" (SrcFile "arraySum.pp5") (Eval [0] (Value 0))
  , Test "arraySum2" (SrcFile "arraySum.pp5") (Eval [3] (Value 6))

  ]