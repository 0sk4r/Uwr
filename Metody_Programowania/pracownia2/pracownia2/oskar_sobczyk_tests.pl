:- module(oskar_sobczyk_tests, [resolve_tests/5, prove_tests/4]).

:- op(200, fx, ~).
:- op(500, xfy, v).


resolve_tests(simple_test, q, p v q, ~q v r, p v r).

resolve_tests(pos_and_neg,p,p,~p,[]).

resolve_tests(repeated_var,p,p v d, ~p v d, d).

resolve_tests(neg_pos_var,p, p v q, ~p v ~q, q v ~q).

resolve_tests(repeated_negvar,p,p v ~q, ~p v ~q, ~q).

resolve_tests(repeated2,p,p v p v p v p v p v p v p v q, ~p v ~p v ~p v ~p v ~p v q,q).

resolve_tests(test, q, p v q v p, p v ~q v p, p).

resolve_tests(test2, q, p v ~p v q, p v ~p v ~q, p v ~p).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prove_tests(example, validity, [p v q v ~r, ~p v q, r v q, ~q, p], unsat).
prove_tests(excluded_middle, validity, [p v ~p], sat).


%SAT

prove_tests(single_var_sat,validity,[p],sat).

prove_tests(single_negvar_sat,validity,[~p],sat).

prove_tests(var2_sat,validity,[p,q],sat).

prove_tests(negvar2_sat,validity,[~p,~q],sat).

prove_tests(clause_2var,validity,[p v q],sat).

prove_tests(clause2negvar,validity,[~p v ~q],sat).

prove_tests(short_tautology, validity,[p v ~p],sat).

prove_tests(long_single_var, validity,[p,p,p,p,p,p,p,p,p,p,p,p,p],sat).

prove_tests(sat, validity, [q v ~q, p v ~q, ~p],sat).

prove_tests(sat_perf,performance, [ p v q v r, ~r v ~q v ~p, ~q v r, ~r v p ], sat).

prove_tests(sat_perf2, performance, [p v q v r, ~r v ~q v ~p, ~q v r, ~r v p],sat).


%UNSAT

prove_tests(unsat1, validity, [ ~p v q, ~p v ~r v s, ~q v r, p, ~s ],unsat).

prove_tests(unsat2, validity, [ p v r, ~r v ~s, q v s, q v r, ~p v ~q, s v p ], unsat).

prove_tests(unsat3, validity, [p,p v r, q v q,q,~p],unsat).

prove_tests(unsat4, validity, [p v q, ~p v q, p v ~q, ~p v ~q],unsat).

prove_tests(short_unsat5, validity,[p v q,~p,~q],unsat).

prove_tests(single_var_unsat, validity,[p,~p],unsat).

prove_tests(short,validity,[p v p, ~p],unsat).

prove_tests(unsat5, validity,[~t v a, ~t v ~r v s, ~a v r,t,~s],unsat).

prove_tests(unsat6, validity,[p v s, ~s v r, ~p v r, ~r v z, ~z],unsat).
