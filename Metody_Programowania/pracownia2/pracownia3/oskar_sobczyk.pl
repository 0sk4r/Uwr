% Definiujemy moduł zawierający rozwiązanie.
% Należy zmienić nazwę modułu na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} należy podstawić odpowiednio swoje imię
% i nazwisko bez wielkich liter oraz znaków diakrytycznych
:- module(oskar_sobczyk, [parse/3]).




/*
   A SIMPLE PARSER FOR THE `WHILE' LANGUAGE
   
   Example program:

      n := 10;
      f := 1;
      while n > 1 do
         f := n * f;
         n := n - 1;
      done

   and its abstract syntax tree generated by the parser:
      
      n := constant(10) ';;'
      f := constant(1) ';;'
      while(variable(n) > constant(1),
             f := variable(n) * variable(f) ';;'
             n := variable(n) - constant(1)
           )

   where for convenience we defined:

      :- op(990, xfy, ';;').
      :- op(900, xfy, :=).
      :- op(820, xfy, and).
      :- op(840, xfy, or).
      :- op(700, xfy, <=).
      :- op(700, xfy, <>).
   
   See below for the formal description of the lexical structure and
   context-free grammar of the While language.
*/

/*
   LEXICAL ANALYSIS

   Lexical structure:
      - symbols:     := ; ( ) + - * = <> <= < >= >
      - constants:   nonempty sequences of digits 0 .. 9
      - keywords:    and div do done else false fi if mod not or skip
                     then true false while
      - variables:   sequences of small and capital letters and digits
                     that start with a letter and are different from
                     keywords
   Scanning assumes the maximal munch rule. Tokens can (and sometimes
   should) be separated with an arbitrary number of white space
   characters (spaces, tabs, newline characters etc.)
*/ 

lexer(Tokens) -->
   white_space,
   (  (  "=",      !, { Token = tokAssgn }
      ;  "(",       !, { Token = tokLParen }
      ;  ")",       !, { Token = tokRParen }
      ;  "+",       !, { Token = tokPlus }
      ;  "-",       !, { Token = tokMinus }
      ;  "*",       !, { Token = tokTimes }
      ;  "=",       !, { Token = tokEq }
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
      ;  "|"        !, { Token = tokOr}
      ;  "&"        !, { Token = tokAnd}
      ;  "/"        !, { Token = tokDiv}
      ;  "%"        !, { Token = tokMod}
      ;  "@"        !, { Token = tokMa}
      ;  "#"        !, { Token = tokHash}
      ;  "~"        !, { Token = tokNot}
      
      ;  digit(D),  !,
            number(D, N),
            { Token = tokNumber(N) }
      
      ;  letter(L), !, identifier(L, Id),
            {  member((Id, Token), [ (def, tokDef),
                                     (else, tokElse),
                                     (if, tokIf),
                                     (in, tokIn),
                                     (let, tokLet),
                                     (then, tokThen),
                                     (_, tokUnderline),
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

white_space -->
   [Char], { code_type(Char, space) }, !, white_space.
white_space -->
   [].
   
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



% Główny predykat rozwiązujący zadanie.
% UWAGA: to nie jest jeszcze rozwiązanie; należy zmienić jego
% definicję.
parse(_Path, Codes, Program) :-
  Codes = [], Program = [].
