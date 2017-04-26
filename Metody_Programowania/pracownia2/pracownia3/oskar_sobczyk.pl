% Definiujemy moduł zawierający rozwiązanie.
% Należy zmienić nazwę modułu na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} należy podstawić odpowiednio swoje imię
% i nazwisko bez wielkich liter oraz znaków diakrytycznych
:- module(oskar_sobczyk, [parse/3]).
 

lexer(Tokens) -->
   white_space,
   (  (  "=",      !, { Token = tokAssgn }
      ;  "_",       !, {Token = tokUnderline}
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
   [L], { code_type(L, alpha) }.

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


%dziala
wzorzec(X) -->
    ([tokVar(Var)],( [tokComma],!,  wzorzec(Res2), {X = pair(no, var(no,Var), Res2)}
                   ; [], {X = var(no, Var)})

    ;[tokUnderline], !, {X = empty(no)}

    ;[tokLParen], !, wzorzec(Res), [tokRParen], {X = Res}

    ).


wyrazenie(X) -->
    ([tokIf],!, wyrazenie(Expr1), [tokThen], wyrazenie(Expr2), [tokElse], wyrazenie(Expr3), {X = if(no, Expr1, Expr2, Expr3)}

    ; [tokLet],!, wzorzec(W), [tokAssgn], wyrazenie(Expr1), [tokIn], wyrazenie(Expr2), {X = let(no, W, Expr1, Expr2)}

    ; wyrazenie_op(W),!, {X = W}
    
    ).

wyrazenie_op(X) -->
    (wyrazenie_proste(W),!, {X = W}
    
    ; wyrazenie_op(W1), op_bin(Op),!, wyrazenie_op(W2), {X = op(no, Op, W1, W2)}
    
    ; op_un(Op), !, wyrazenie_op(W1), {X = op(no,Op,W1)}

    ;wyrazenie_op(W1), [tokComma],!, wyrazenie_op(W2), {X = pair(no, W1, W2)}
    ).

wyrazenie_proste(X) -->
    ( wyrazenie_atomowe(X),!
    
    %; wybor_bitu(X),!
    
    ; wybor_bitow(X),!

    ; [tokLParen],!,  wyrazenie(W), [tokRParen], { X = W}
    
    ).

wybor_bitow(X) --> 
    wyrazenie_proste(Wp), [tokLSParen], wyrazenie(W1),( [tokDDot], wyrazenie(W2), {X = bitsel(no, Wp, W1, W2)}
                                                        ; wyrazenie(W), [tokRSParen], {X = bitsel(no, Wp, W) }).




wyrazenie_atomowe(X) -->
    ([tokVar(Var)],([tokLParen],!, wyrazenie(W), [tokRParen], {X = call(no, Var, W)}
                    ;[],!, {X = var(no, Var)}
    
    ; [tokNumber(Num)],!, {X = num(no, Num)}
    
    %; wywolanie_funkcji(W),!, {X = W}

    ; pusty_wektor(W),!, {X = W}

    ; pojedynczy_bit(B),!, {X = B}
    ).

wywolanie_funkcji(Call) -->
    [tokVar(Id)], [tokLParen], wyrazenie(W), [tokRParen], {Call = call(no, Id, W)}.

pusty_wektor(X) --> [tokLParen], [tokRParen],!, {X = empty(no)}.

pojedynczy_bit(X) --> [tokLSParen], wyrazenie(W), [tokRSParen], {X = bit(no, W)}.



% Główny predykat rozwiązujący zadanie.
% UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jego
% definicję.
parse( Codes, Absynt) :-
  phrase(lexer(Program), Codes),
  phrase(program(Absynt),Program).

parsuj(Kod, Wynik) :- phrase(program(Wynik),Kod).

lexuj(Kod,Wynik) :- phrase(lexer(Wynik),Kod).