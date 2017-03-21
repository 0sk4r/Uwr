% Definiujemy modu³ zawieraj¹cy testy.
% Nale¿y zmieniæ nazwê modu³u na {imie}_{nazwisko}_tests gdzie za
% {imie} i {nazwisko} nale¿y podstawiæ odpowiednio swoje imiê
% i nazwisko bez znaków diakrytycznych
:- module(oskar_sobczyk_tests, [tests/5]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% Zbiór faktów definiuj¹cych testy
% Nale¿y zdefiniowaæ swoje testy

tests(empty, validity, [], 500, count(0)).

tests(single_var, validity, [p], 500, solution([(p,t)])).
tests(single_var_count, validity, [p],500,count(1)).

tests(single_var_neg, validity, [~p],500, solution([(p,f)])).
tests(single_var_neg_count, validity, [~p],500, count(1)).

tests(negation_solution, validity, [~p,~r,~d,~q,~w],1000,solution([(p,f),(r,f),(d,f),(q,f),(w,f)])).
tests(negation_count, validity, [~p,~r,~d,~q,~w],1000,count(1)).

tests(false, validity, [p, ~p], 500, count(0)).

tests(independent_var_solution, validity, [p v ~p], 500, count(2)).

tests(multiple_single_var, validity, [~p,~q,w,~d,a,x], 1000, solution([(p,f),(q,f),(w,t),(d,f),(a,t),(x,t)])).

tests(independent2_count,validity,[p v q, ~q v p], 1000, count(2)).
tests(independent2_sol,validity,[p v q, ~q v p], 1000, solution([(p,t),(q,f)])).

tests(test_count,validity,[p v q v r, ~r v ~q v ~p, ~q v r, ~r v p],1500, count(2)).
tests(test_solution,validity,[p v q v r, ~r v ~q v ~p, ~q v r, ~r v p],1500, solution([(p,t),(q,f),(r,t)])).

tests(long_clausule_count, validity,[p v r v q v d v s], 5000, count(31)).

tests(unsatisfiable_clausule, validity,[~p v q, ~p v ~r v s, ~q v r, p,~s],5000,count(0)).

tests(and_with_or_solution,validity, [p, q v r],1000, count(3)).
tests(and_with_or_count,validity, [p, q v r],1000,  solution([(p,t),(q,f),(r,t)])).

tests(test, validity, [q v ~q, p v ~q, ~p],1000, solution([(p,f),(q,f)])).

% Testy wydajnosciowe sprawdzaja przypadki w ktorych mamy duzo
% pojedynczych zmiennych co sprawia ze znalezienie poprawnego
% wartosciowania powinno byc szybkie poniewaz kazda pojedyncza zmienna
% musi byc True
tests(lot_of_single_var, performance,[p,q,e,r,t,d,s,c,x,t,e,d,b],1000,count(1)).
tests(single_var_with_clausule,performance, [p v q v r v d v s v x, p,q,r,d,s,x], 1000, count(1)).
tests(lot_of_neg_var, performance, [~p,~q,~w,~r,~x,~e,~s,~a,~b,~t,~c],1000, count(1)).
