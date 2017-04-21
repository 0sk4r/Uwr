% Definiujemy moduł zawierający testy.
% Należy zmienić nazwę modułu na {imie}_{nazwisko}_tests gdzie za
% {imie} i {nazwisko} należy podstawić odpowiednio swoje imię
% i nazwisko bez wielkich liter oraz znaków diakrytycznych
:- module(imie_nazwisko_tests, [tests/3]).

% Zbiór faktów definiujących testy
% Należy zdefiniować swoje testy
tests(empty_program, input(""), program([])).
tests(invalid, input("def main()"), no).
tests(adder, file('adder.hdml'), yes).
tests(srcpos, input("def main(_) = 1"),
  program([def(main, wildcard(file(test, 1, 10, 9, 1)), num(no, 1))])).


tests(empty,input(""),yes).
tests(multiple_def,file('multiple_def.hdml'),yes).
tests(def_in_def,file('def_in_def.hdml'),no).
tests(wrong_def_identifier1,input("def 9test(_) = 1"),no).
tests(wrong_def_identifier2,input("def test#(_) = 1"),no).
tests(def_with_wrong_var,input("def test(9abc)"),no).
tests(identifier_starts_with_underline,input("def _test(_) = 1"),program([def(_test, wildcard(no), num(no, 1))])).
tests(def_with_single_var,input("def test(Var) = 1"), program([def(test, var(no, Var), num(no, 1))])).
tests(def_with_multvar, input("def test(Var1, Var2, Var3) = 3"), yes).
tests(simple_if, file('simple_if.hdml'),program([def(test, pair(no, var(no,'A'), var(no,'B')), if(no, op(no, '>', var(no, 'A'), num(no, 0)),var(no,'B'),empty(no)))])).
tests(wrong_if, file('wrong_if.hdml'),yes).
tests(function_call, file('function_call.hdml'),yes).
tests(test2, file('test2.hdml'), yes).
tests(simple_let, file('simple_let.hdml'),program([def(test2,var(no,'A')),let(no, var(no,'C'),num(no,1),op(no,'&',var(no,'A'),var(no,'C')))])).
tests(unary_op, file('unary_op.hdml'),program )
tests(more_var_def,input("det test(A,B,C,D,E) = 1"),yes).
tests(more_var_def2,input("def test(A,B,C,D) = 1"),yes).
def(test,var(no,'A')),
	let(no,var(no, 'C'),op(no,~,var(no,'A')),)
