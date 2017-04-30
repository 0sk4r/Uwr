/*
    lexer:
    operators: + - * < <= > >= = <> := ;
    key words: and begin call div do done else end fi if local mod not or procedure program read return then value while write
    comments: char sing sequences started with (* and ended with *)
    identificators: sequences of ASCII letters, digits 0-9, signs _ and '
*/

lexer(Tokens) -->
   blank_sign,
   (  (  ":=",      !, { Token = tokAssgn }
      ;  ";",       !, { Token = tokSColon }
      ;  "(",       !, { Token = tokLParen }
      ;  ")",       !, { Token = tokRParen }
      ;  "+",       !, { Token = tokAdd }
      ;  "-",       !, { Token = tokSub }
      ;  "*",       !, { Token = tokMul }
      ;  "=",       !, { Token = tokE }
      ;  "<>",      !, { Token = tokD }
      ;  "<=",      !, { Token = tokLE }
      ;  "<",       !, { Token = tokL } 
      ;  ">=",      !, { Token = tokGE }
      ;  ">",       !, { Token = tokG }
      ;  ",",       !, { Token = tokComma } 
      ;  digit(D),  !,
            number(D, N),
            { Token = tokNumber(N) }
      ;  letter(L), !, identifier(L, Id),
            {  member((Id, Token), [ (and, tokAnd),
                                     (begin, tokBegin),
                                     (call, tokCall),
                                     (div, tokDiv),
                                     (do, tokDo),
                                     (done, tokDone),
                                     (else, tokElse),
                                     (end, tokEnd),
                                     (fi, tokFi),
                                     (if, tokIf),
                                     (tokLocal, tokLocal),
                                     (mod, tokMod),
                                     (not, tokNot),
                                     (or, tokOr),
                                     (procedure, tokProc),
                                     (program, tokProgram),
                                     (read, tokRead),
                                     (return, tokReturn),
                                     (then, tokThen),
                                     (value, tokValue),
                                     (while, tokWhile),
                                     (write, tokWrite) ]),
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

blank_sign -->
   [Char], { code_type(Char, space) }, !, blank_sign.
blank_sign -->
    "(*", !, comment.
blank_sign -->
   [].
comment -->
      "*)", !, blank_sign.
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

/*
  PARSER
  Desription of algol 16 syntax in exercise content
*/

program(Ast) -->
   [tokProgram],
   [tokVar(Program_Id)],
   block(Bl),
   { Ast = (Program_Id, Bl) }.
block(Bl) --> 
  declarations(Dec),
  [tokBegin],
  instruction_set(Instr),
  [tokEnd],
  { Bl = block_(Dec, Instr) }.

declarations(Dec) -->
    single_dec(Dec2), !, declarations(Rest), { append(Dec2, Rest, Dec) }.
declarations([]) -->
    [].

single_dec(Dec) -->
     (declarator(Dec) ; procedure(Dec) ).

declarator(Dec) -->
    [tokLocal], vars(Dec).

vars(Var) -->
    single_var(V), ( [tokComma], !, vars(Rest), 
    {Var = [variable(V) | Rest] }
    ; [], { Var = [variable(V)] } ).
single_var(Var) -->
      [tokVar(Var)]. 

procedure(Proc) -->
    [tokProc], proc_name(Name), [tokLParen], proc_arg(Args), [tokRParen], block(Bl),
    { Proc = [proc(Name, Args, Bl)] }.
proc_arg(Args) -->
    proc_arg_set(Args), !.
proc_arg([]) -->
    [].
proc_arg_set(Args) --> 
    single_proc_arg(Arg), ( [tokComma], !, proc_arg_set(Rest),
    { Args = [Arg | Rest] }
    ; [], { Args = [Arg] } ).
single_proc_arg(Arg) -->
    [tokValue], !, single_var(V), { Arg = variable(V) }.
single_proc_arg(Arg) -->
    single_var(V), { Arg = variable(V) }.

instruction_set(Ast) -->   
   instruction(Instr),
   (  [tokSColon], !, instruction_set(Rest),
         { append([Instr], Rest, Ast) }
   ;  [],
         { Ast = [Instr] }
   ).

instruction(Instr) -->
   (  [tokWhile], !, bool_expr(Bool), [tokDo], instruction_set(Body), [tokDone],
          { Instr = while(Bool, Body) }
   ;  [tokIf], !, bool_expr(Bool), [tokThen], instruction_set(ThenPart),
         (  [tokElse], !, instruction_set(ElsePart), [tokFi],
               { Instr = if(Bool, ThenPart, ElsePart) }
         ;  [tokFi],
               { Instr = if(Bool, ThenPart) }
         )
   ;  [tokCall], !, proc_call(Call),
         { Instr = call_(Call) }
   ;  [tokReturn], !, arith_expr(Expr),
         { Instr = return_(Expr) }
   ;  [tokRead], !, [tokVar(Id)], 
         { Instr =  read_(variable(Id)) }
   ;  [tokWrite], !, arith_expr(Expr),
          { Instr = write_(Expr) }
   ;  [tokVar(Var), tokAssgn], arith_expr(Expr),
         { Instr = assgn_(variable(Var), Expr) }
   ).
   
proc_call(Proc) -->
    proc_name(PName), [tokLParen], arguments(Arg), [tokRParen],
        { Proc = ( PName, Arg )}.
proc_name(ProcName) -->
    [tokVar(ProcName)].
arguments(Args) -->
    ( args_set(Args), ! ; [], { Args = [] } ).

args_set(Args) -->
    simple_arg(Arg), ( [tokComma], !, args_set(Rest),
    { Args = [Arg | Rest] }
    ; [], { Args = [Arg] }  ).

simple_arg(Arg) -->
    arith_expr(Arg).

arith_expr(Expr) -->
   summand(Summand), arith_expr(Summand, Expr).

arith_expr(Acc, Expr) -->
   additive_op(Op), !, summand(Summand),
      { Acc1 = [Op, Acc, Summand] }, arith_expr(Acc1, Expr).
arith_expr(Acc, Acc) -->
   [].

summand(Expr) -->
   factor(Factor), summand(Factor, Expr).

summand(Acc, Expr) -->
   multiplicative_op(Op), !, factor(Factor),
      { Acc1 = [Op, Acc, Factor] }, summand(Acc1, Expr).
summand(Acc, Acc) -->
   [].

factor(Expr) -->
    [tokSub], !, simp_expr(NewExpr), { Expr = -NewExpr }.
factor(Expr) -->
    simp_expr(Expr).

simp_expr(Expr) -->
    [tokLParen], !, arith_expr(Expr), [tokRParen].
simp_expr(Expr) -->
    atom_expr(Expr).

atom_expr(Expr) -->
    [tokNumber(N)], !, { Expr = constant(N) }.
atom_expr(Expr) -->
    proc_call(Call), !, { Expr = call_(Call) }.
atom_expr(Expr) -->
    [tokVar(Var)], { Expr = variable(Var) }.


bool_expr(Bool) -->
   conjunct(Conjunct), bool_expr(Conjunct, Bool).

bool_expr(Acc, Bool) -->
   [tokOr], !, conjunct(Conjunct),
      { Acc1 = [or, Acc, Conjunct] }, bool_expr(Acc1, Bool).
bool_expr(Acc, Acc) -->
   [].

conjunct(Conjunct) -->
   condit(Condit), conjunct(Condit, Conjunct).

conjunct(Acc, Conjunct) -->
   [tokAnd], !, condit(Condit),
      { Acc1 = [and, Acc, Condit] }, conjunct(Acc1, Conjunct).
conjunct(Acc, Acc) -->
   [].

condit(Condit) -->
    [tokNot], !, rel_expr(NewCondit), { Condit = not(NewCondit) }.
condit(Condit) -->
    rel_expr(Condit).

rel_expr(Expr) -->
   (  [tokLParen], bool_expr(Expr), !, [tokRParen]
   ;  arith_expr(LExpr), rel_op(Op), arith_expr(RExpr),
         { Expr = [Op, LExpr, RExpr] }
   ).

additive_op(+) -->
   [tokAdd], !.
additive_op(-) -->
   [tokSub].

multiplicative_op(*) -->
   [tokMul], !.
multiplicative_op(//) -->
   [tokDiv], !.
multiplicative_op(mod) -->
   [tokMod].

rel_op(=) -->
   [tokE], !.
rel_op(<>) -->
   [tokD], !.
rel_op(<) -->
   [tokL], !.
rel_op(<=) -->
   [tokLE], !.
rel_op(>) -->
   [tokG], !.
rel_op(>=) -->
   [tokGE].