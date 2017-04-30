% Definiujemy moduł zawierający rozwiązanie.
% Należy zmienić nazwę modułu na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} należy podstawić odpowiednio swoje imię
% i nazwisko bez wielkich liter oraz znaków diakrytycznych
:- module(oskar_sobczyk, [parse/3]).


%Za poprawne komentarze uznajemy (* wewnatrz moze byc wszystko poza "*)" *)

lexer(Tokens) -->
   white_space,
   (  (  "=",      !, { Token = tokAssgn }
      ;  "(",       !, { Token = tokLParen }
      ;  ")",       !, { Token = tokRParen }
      ;  "+",       !, { Token = tokPlus }
      ;  "-",       !, { Token = tokMinus }
      ;  "*",       !, { Token = tokTimes }
      ;  "<>",      !, { Token = tokNeq }
      ;  "<=",      !, { Token = tokLeq }
      ;  "<",       !, { Token = tokLt }
      ;  ">=",      !, { Token = tokGeq }
      ;  ">",       !, { Token = tokGt }
      ;  "[",       !, { Token = tokLSParen}
      ;  "]",       !, { Token = tokRSParen}
      ;  "..",      !, { Token = tokDDot}
      ;  ",",       !, { Token = tokComma}
      ;  "^",       !, { Token = tokPower}
      ;  "|",        !, { Token = tokOr}
      ;  "&",        !, { Token = tokAnd}
      ;  "/",        !, { Token = tokDiv}
      ;  "%",        !, { Token = tokMod}
      ;  "@",        !, { Token = tokMa}
      ;  "#",        !, { Token = tokHash}
      ;  "~",        !, { Token = tokNot}

      ;  digit(D),  !,
            number(D, N),
            { Token = tokNumber(N) }

      ;  letter(L), !, identifier(L, Id),
            {  member((Id, Token), [ (def, tokDef),
				     ('_', tokUnderline),
                                     (else, tokElse),
                                     (if, tokIf),
                                     (in, tokIn),
                                     (let, tokLet),
                                     (then, tokThen)
                                     ]),
               !
            ;  Token = tokVar(Id)
            }


      ;  [_],
            { Token = tokUnknown }
      ),
      !,
         { Tokens = [Token | TokList] },
      lexer(TokList)
    ;  [],
         { Tokens = [] }
   ).


white_space-->
   [Char], { code_type(Char, space) }, !, white_space.
white_space -->
    "(*", !, comment.
white_space -->
   [].
comment -->
      "*)", !, white_space.
comment -->
      [_], !, comment.


digit(D) -->
   [D],
      { code_type(D, digit) }.

digits([D|T]) -->
   digit(D),
   !,
   digits(T).
digits([]) -->
   [].

number(D, N) -->
   digits(Ds),
      { number_chars(N, [D|Ds]) }.

letter(L) -->
   [L], { code_type(L, alpha);  L = 95 }.

alphanum([A|T]) -->
    [A], { code_type(A, alnum) ; A = 39 ; A = 95 }, !, alphanum(T).

alphanum([]) -->
   [].

identifier(L, Id) -->
   alphanum(As),
      { atom_codes(Id, [L|As]) }.



%%%%%%%%%%%% PARSER %%%%%%%%%%%%%%%%%%
program(X) --> definicje(X).

definicje(X) --> definicja(Res1),!,  definicje(Res2), { X = [Res1 | Res2]}.

definicje([]) --> [].

definicja(X) -->
    [tokDef],
    [tokVar(Name)],
    [tokLParen],
    wzorzec(P),
    [tokRParen],
    [tokAssgn],
    wyrazenie(E),
    { X = def(Name,P,E)}.


wzorzec(X) --> wzorzec2(W1), [tokComma], !, wzorzec(W2),{X = pair(no,W1,W2)}.
wzorzec(X) --> wzorzec2(X).

wzorzec2(X) --> ( [tokVar(W)],{X = var(no,W)}
		   ;[tokUnderline],!, {X = wildcard(no)}
		   ;[tokLParen], !, wzorzec(Res), [tokRParen], {X = Res}).
wyrazenie(X) -->
    ([tokIf],!, wyrazenie(Expr1), [tokThen], wyrazenie(Expr2), [tokElse], wyrazenie(Expr3), {X = if(no, Expr1, Expr2, Expr3)}

    ; [tokLet],!, wzorzec(W), [tokAssgn], wyrazenie(Expr1), [tokIn], wyrazenie(Expr2), {X = let(no, W, Expr1, Expr2)}

    ; wyrazenie_op1(W),!, {X = W}

    ).
wyrazenie_op1(X) --> wyrazenie_op2(W1),op_bin1(_),wyrazenie_op1(W2),{X = pair(no,W1,W2)}.

wyrazenie_op1(X) -->
  op_un(Op), wyrazenie_op1(W),{X = op(no,Op,W)}.

wyrazenie_op1(X) --> wyrazenie_op2(X).


wyrazenie_op2(X) --> wyrazenie_op3(W1), op_bin2(Op), wyrazenie_op3(W2), {X = op(no, Op, W1, W2)}.

wyrazenie_op2(X) -->
  op_un(Op), wyrazenie_op2(W),{X = op(no,Op,W)}.


wyrazenie_op2(X) --> wyrazenie_op3(X).


wyrazenie_op3(X) --> wyrazenie_op4(W1), op_bin3(Op), wyrazenie_op3(W2), {X = op(no, Op,W1,W2)}.

wyrazenie_op3(X) -->
  op_un(Op), wyrazenie_op3(W),{X = op(no,Op,W)}.


wyrazenie_op3(X) --> wyrazenie_op4(X).


wyrazenie_op4(X) --> wyrazenie_op5(A), wyrazenie_op4(A, X).

wyrazenie_op4(X) -->
  op_un(Op), wyrazenie_op4(W),{X = op(no,Op,W)}.

wyrazenie_op4(X) --> wyrazenie_op5(X).

wyrazenie_op4(A, X) --> op_bin4(Op), wyrazenie_op5(W), {Acc1 = op(no,Op, A, W)}, wyrazenie_op4(Acc1, X).

wyrazenie_op4(X,X) --> [].



wyrazenie_op5(X) --> wyrazenie_op6(A), wyrazenie_op5(A, X).

wyrazenie_op5(X) -->
  op_un(Op), wyrazenie_op5(W),{X = op(no,Op,W)}.

wyrazenie_op5(X) --> wyrazenie_op6(X).

wyrazenie_op5(A, X) --> op_bin5(Op), wyrazenie_op6(W), {Acc1 = op(no,Op, A, W)}, wyrazenie_op5(Acc1, X).

wyrazenie_op5(X,X) --> [].


wyrazenie_op6(X) --> wyrazenie_proste(X).


op_un('-') --> [tokMinus].
op_un('#') --> [tokHash].
op_un('~') --> [tokNot].

op_bin1(',') --> [tokComma].

op_bin2('=') --> [tokAssgn].
op_bin2('<>') --> [tokNeq].
op_bin2('<') --> [tokLt].
op_bin2('>') --> [tokGt].
op_bin2('<=') --> [tokLeq].
op_bin2('>=') --> [tokGeq].

op_bin3('@') --> [tokMa].

op_bin4('|') --> [tokOr].
op_bin4('^') --> [tokPower].
op_bin4('+') --> [tokPlus].
op_bin4('-') --> [tokMinus].

op_bin5('&') --> [tokAnd].
op_bin5('*') --> [tokTimes].
op_bin5('/') --> [tokDiv].
op_bin5('%') --> [tokMod].


wyrazenie_proste(X) -->
    (wybor_bitow(X),!

    ;wyrazenie_atomowe(W), {X = W}

    ;[tokLParen],!,  wyrazenie(W), [tokRParen], { X = W}

    ).

wybor_bitow(X) -->
   wyrazenie_proste2(Wp), [tokLSParen], wyrazenie(W1),( [tokDDot], wyrazenie(W2),[tokRSParen], {Y = bitsel(no, Wp, W1, W2)}
                                                        ; [tokRSParen], {Y = bitsel(no, Wp, W1) }),wybor_bitow(Y),{X = Y}.


wybor_bitow(X) -->  wyrazenie_proste2(Wp), [tokLSParen],!, wyrazenie(W1),( [tokDDot], wyrazenie(W2),[tokRSParen], {X = bitsel(no, Wp, W1, W2)}
                                                        ; [tokRSParen], {X = bitsel(no, Wp, W1) }).


wyrazenie_proste2(X) -->
    ( wyrazenie_atomowe(W), {X = W}
    ; [tokLParen],!,  wyrazenie(W), [tokRParen], { X = W}
    ).



wyrazenie_atomowe(X) --> [tokVar(Var)],[tokLParen],!, wyrazenie(W), [tokRParen], {X = call(no, Var, W)}.

wyrazenie_atomowe(X) -->
    ([tokVar(Var)], {X = var(no, Var)}

    ; [tokNumber(Num)],!, {X = num(no, Num)}

    ; pusty_wektor(W),!, {X = W}

    ; pojedynczy_bit(B),!, {X = B}
    ).

pusty_wektor(X) --> [tokLSParen], [tokRSParen],!, {X = empty(no)}.

pojedynczy_bit(X) --> [tokLSParen], wyrazenie(W),!, [tokRSParen], {X = bit(no, W)}.



% Główny predykat rozwiązujący zadanie.
% UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jego
% definicję.
parse(_Path,Codes, Absynt) :-
  phrase(lexer(Program), Codes),
  phrase(program(Absynt),Program).
