% Definiujemy modu� zawieraj�cy testy.
% Nale�y zmieni� nazw� modu�u na {imie}_{nazwisko}_tests gdzie za
% {imie} i {nazwisko} nale�y podstawi� odpowiednio swoje imi�
% i nazwisko bez znak�w diakrytycznych
:- module(imie_nazwisko_tests, [tests/5]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% Zbi�r fakt�w definiuj�cych testy
% Nale�y zdefiniowa� swoje testy
tests(excluded_middle, validity, [p v ~p], 500, solution([(p,t)])).




