% Definiujemy modu³ zawieraj¹cy testy.
% Nale¿y zmieniæ nazwê modu³u na {imie}_{nazwisko}_tests gdzie za
% {imie} i {nazwisko} nale¿y podstawiæ odpowiednio swoje imiê
% i nazwisko bez wielkich liter oraz znaków diakrytycznych
:- module(imie_nazwisko_tests, [resolve_tests/5, prove_tests/4]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% Zbiór faktów definiuj¹cych testy dla predykatu resolve
% Nale¿y zdefiniowaæ swoje testy
resolve_tests(simple_test, q, p v q, ~q v r, p v r).

resolve_tests(pos_and_neg,p,p,~p,[]).
resolve_tests(repeated_var,p,p,p v ~p,[]).
resolve_tests(repeated_var2,p,p v q v d,q v e v ~p,d v e).



% Zbiór faktów definiuj¹cych testy dla predykatu prove
% Nale¿y zdefiniowaæ swoje testy
prove_tests(example, validity, [p v q v ~r, ~p v q, r v q, ~q, p], unsat).
prove_tests(excluded_middle, validity, [p v ~p], sat).
