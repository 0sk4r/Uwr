% Definiujemy modu� zawieraj�cy testy.
% Nale�y zmieni� nazw� modu�u na {imie}_{nazwisko}_tests gdzie za
% {imie} i {nazwisko} nale�y podstawi� odpowiednio swoje imi�
% i nazwisko bez wielkich liter oraz znak�w diakrytycznych
:- module(imie_nazwisko_tests, [resolve_tests/5, prove_tests/4]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% Zbi�r fakt�w definiuj�cych testy dla predykatu resolve
% Nale�y zdefiniowa� swoje testy
resolve_tests(simple_test, q, p v q, ~q v r, p v r).

% Zbi�r fakt�w definiuj�cych testy dla predykatu prove
% Nale�y zdefiniowa� swoje testy
prove_tests(example, validity, [p v q v ~r, ~p v q, r v q, ~q, p], unsat).
prove_tests(excluded_middle, validity, [p v ~p], sat).
