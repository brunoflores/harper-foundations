%{
  open Syntax
%}

/* Keyword tokens */
/* %token LET */
/* %token BE */
/* %token IN */

/* Identifier and constant value tokens */
/* %token <string> UCID */
/* %token <string> LCID */
%token <int> INTV

/* Symbolic tokens */
%token EOF

%start <exp> start

%%

start:
  | e = exp EOF
    { e }

exp:
  | e = INTV
    { Num e }
