% Sprawdzaczka do zadania 2
%
% Sprawdzaczk� nale�y uruchomi� w katalogu w kt�rym znajduj� si� testy
% i rozwi�zania:
%
% $ swipl prac2.pl
%
% Predykat test_all/0 uruchamia rozwi�zanie na wszystkich testach
% is wy�wietla raport. np.
%
% ?- test_all.
% excluded_middle                0.003s ok
% wrong_test                     0.000s wrong answer
% invalid_test                   invalid test
% big_test                       tle
% tricky                         3.243s invalid answer
%
% Predykaty test_all_resolve/0 oraz test_all_prove/0 dzia�aj� podobnie,
% z t� r�nic�, �e uruchamiaj� tylko testy dla predykatu odpowiednio
% resolve/4 oraz prove/2
%
% Za pomoc� predykatu run_test/1 mo�na uruchomi� pojedynczy test podaj�c
% jego nazw�:
%
% ?- run_test(excluded_middle).
% excluded_middle                0.003s ok
%
% Dla ka�dego uruchomionego testu sprawdzaczka wy�wietla czas dzia�ania
% (o ile test si� w~pe�ni wykona�) oraz status wykonania. Mo�liwe warto�ci
% to:
%
% ok             - program przeszed� test
% wrong answer   - b��dna odpowied�
% tle            - przekroczony limit czasu
% invalid test   - niepoprawny format testu
% invalid answer - niepoprawna format rozwi�zania. W przypdaku predykatu
%     resolve/4 mo�e oznacza�, �e predykat zako�czy� si� wi�cej ni�
%     jednym sukcesem
%
% Sprawdzaczka udost�pnia jeszcze dwa predykty, u�atwiaj�ce odpluskwianie
% kodu:
%
% show_proof(+Input, +Proof) - wy�wietla dow�d Proof (np. rezultat dzia�ania
%   predykatu prove/2) w czytelnej postaci. Input powinno by� list� aksjomat�w
%
% test_and_show(+Name) - uruchania predykat prove/2 na te�cie o nazwie Name
%   i wy�wietla wyprodukowany dow�d za pomoc� show_proof
%
% UWAGA: niniejsza sprawdzaczka nie sprawdza wszystkich warunk�w na�o�onych
% na format test�w i wynik�w dzia�ania programu. Zach�camy jednak do
% modyfikowania i ulepszania jej kodu.
%
% Do poprawnego dzia�ania sprawdzaczki nale�y jeszcze zmodyfikowa�
% poni�sze dwa wiersze:
:- use_module(imie_nazwisko_tests).
:- use_module(imie_nazwisko).

:- op(200, fx, ~).
:- op(500, xfy, v).

test_all :-
  run_test(_), fail;
  format("Done!~n", []).

test_all_resolve :-
  run_resolve_test(_), fail;
  format("Done!~n", []).

test_all_prove :-
  run_prove_test(_), fail;
  format("Done!~n", []).

run_test(Name) :-
  run_resolve_test(Name);
  run_prove_test(Name).

run_resolve_test(Name) :-
  resolve_tests(Name, Var, Clause1, Clause2, Resolvent),
  format("~w~t~32+ ", [Name]),
  ( validate_resolve_test(Name, Var, Clause1, Clause2, Resolvent) ->
      catch(run_resolve(Var, Clause1, Clause2, 1000, Resolvent, Status),
        time_limit_exceeded,
        (Status = tle)),
      print_status(Status)
  ; format("invalid test~n")
  ).

run_prove_test(Name) :-
  prove_tests(Name, Type, Input, Ans),
  format("~w~t~32+ ", [Name]),
  ( validate_prove_test(Name, Type, Input, Ans) ->
      type_timeout(Type, Timeout),
      catch(run_prove(Input, Timeout, Ans, Status),
        time_limit_exceeded,
        (Status = tle)),
      print_status(Status)
  ; format("invalid test~n")
  ).

show_proof(Input, Proof) :-
  empty_assoc(Prev),
  show_proof(Proof, 1, Input, Prev).

test_and_show(Name) :-
  prove_tests(Name, _, Input, _),
  once(prove(Input, Proof)),
  show_proof(Input, Proof).

% =============================================================================
% Predykaty pomocnicze

print_status(tle)       :- format("tle~n").
print_status(ok(Time))  :- format("~3fs ok~n", [Time]).
print_status(wa(Time))  :- format("~3fs wrong answer~n", [Time]).
print_status(inv(Time)) :- format("~3fs invalid answer~n", [Time]).

% =============================================================================
% Poprawno�� danych

validate_resolve_test(Name, Var, Clause1, Clause2, Resolvent) :-
  atom(Name),
  is_variable(Var),
  is_clause(Clause1),
  is_clause(Clause2),
  is_clause(Resolvent),
  once(has_literal(Var, Clause1)),
  once(has_literal(~Var, Clause2)).

validate_prove_test(Name, Type, Input, Ans) :-
  atom(Name),
  atom(Type), member(Type, [validity, performance]),
  acyclic_term(Input), ground(Input), maplist(is_clause, Input),
  atom(Ans), member(Ans, [sat, unsat]).

is_variable([]) :- !, fail.
is_variable(X) :- atom(X).

is_literal(X) :- is_variable(X), !.
is_literal(~X) :- is_variable(X).

is_non_empty_clause(L) :- is_literal(L), !.
is_non_empty_clause(L v C) :-
  is_literal(L), is_non_empty_clause(C).

is_clause([]) :- !.
is_clause(C) :- is_non_empty_clause(C).

is_proof_elem((C, Orig)) :-
  is_clause(C),
  is_origin(Orig).

is_origin(axiom).
is_origin((V, N1, N2)) :-
  is_variable(V),
  number(N1),
  number(N2).

has_literal(L, L) :- is_literal(L).
has_literal(L, L v _).
has_literal(L, _ v C) :- has_literal(L, C).

has_literals([], _).
has_literals([L|LS], C) :-
  once(has_literal(L, C)),
  has_literals(LS, C).

equiv_clauses(C1, C2) :-
  subclause(C1, C2),
  subclause(C2, C2).

subclause(C1, C2) :-
  findall(L, has_literal(L, C1), LS),
  has_literals(LS, C2).

% =============================================================================
% Uruchamianie predykatu resolve

run_resolve(Var, Clause1, Clause2, Timeout, Resolvent, Status) :-
  statistics(cputime, T0),
  TimeLimit is Timeout / 1000,
  call_with_time_limit(TimeLimit,
    findall(X, resolve(Var, Clause1, Clause2, X), Solutions)),
  statistics(cputime, T1),
  Time is T1 - T0,
  ( validate_resolve_solutions(Solutions) ->
      check_resolve_solutions(Solutions, Resolvent, Time, Status)
  ; Status = inv(Time)
  ).

validate_resolve_solutions([]).
validate_resolve_solutions([Resolvent]) :-
  is_clause(Resolvent).

check_resolve_solutions([],      _, Time, wa(Time)).
check_resolve_solutions([_,_|_], _, Time, inv(Time)).
check_resolve_solutions([Sol], Resolvent, Time, Status) :-
  equiv_clauses(Sol, Resolvent) -> Status = ok(Time);
  Status = wa(Time).

% =============================================================================
% Uruchamianie predykatu prove

type_timeout(validity,    500).
type_timeout(performance, 10000).

run_prove(Input, Timeout, Ans, Status) :-
  statistics(cputime, T0),
  TimeLimit is Timeout / 1000,
  call_with_time_limit(TimeLimit,
    findall(Proof, once(prove(Input, Proof)), Solutions)),
  statistics(cputime, T1),
  Time is T1 - T0,
  ( validate_proofs(Solutions, Input) ->
      check_prove_solutions(Solutions, Ans, Time, Status)
  ; Status = inv(Time)
  ).

validate_proofs([], _Input).
validate_proofs([Proof], Input) :-
  ground(Proof), acyclic_term(Proof),
  maplist(is_proof_elem, Proof),
  empty_assoc(Prev),
  check_proof(Proof, 1, Input, Prev).

check_proof([([], Orig)], _, Input, Prev) :-
  check_origin(Orig, Input, Prev), !.
check_proof([(C, Orig)|Proof], N, Input, Prev) :-
  check_origin(Orig, C, Input, Prev),
  M is N + 1,
  put_assoc(N, Prev, C, NextPrev),
  check_proof(Proof, M, Input, NextPrev).

check_origin(axiom, C, Input, _) :-
  member(C0, Input),
  equiv_clauses(C, C0).
check_origin((V, N1, N2), C, _, Prev) :-
  get_assoc(N1, Prev, C1),
  get_assoc(N2, Prev, C2),
  once(has_literal(V, C1)),
  once(has_literal(~V, C2)),
  once(resolve(V, C1, C2, C0)),
  equiv_clauses(C, C0).

check_prove_solutions([], sat, Time, ok(Time)).
check_prove_solutions([], unsat, Time, wa(Time)).
check_prove_solutions([_], sat, Time, wa(Time)).
check_prove_solutions([_], unsat, Time, ok(Time)).

% =============================================================================
% Drukowanie dowodu

show_proof([], _, _, _) :-
  format("incomplete proof~n", []).
show_proof([(C, Orig)|Proof], N, Input, Prev) :-
  format("~t~w~4+   ~w~t~55+ ~w~t~15+", [N, C, Orig]),
  ( check_origin(Orig, C, Input, Prev) ->
      format("~n")
  ; format("error!~n")
  ),
  M is N + 1,
  put_assoc(N, Prev, C, NextPrev),
  ( Proof=[], C=[], !; show_proof(Proof, M, Input, NextPrev)).














