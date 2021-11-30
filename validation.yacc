%{
#include <stdio.h>
#include <string.h>
extern int yylex();
void yyerror(char *);

int lineno = 1;
%}

%token WHILE DO ENDWHILE
IF THEN ELSE ENDIF
ADD MINUS
NUM VAR
ASIGN
AND OR
NOTEQ EQUAL LTHAN LTOREQ GTHAN GTOREQ
SEMI
RETURN
JUNK

%%

/* print success after returns??*/

prog: blocks | stmts
blocks: block | block blocks | nwln block
block: cdtnl | wstmt | stmts cdtnl | stmts wstmt
stmts: stmt | stmts stmt
stmt: val op | val endop | err
err: JUNK

val: VAR | NUM 
op: ADD | MINUS | ASIGN 
nwln: RETURN
endop: SEMI RETURN

equalities: EQUAL | NOTEQ | LTHAN | LTOREQ | GTHAN | GTOREQ 
lgcl: AND | OR 
eqexpress: val equalities val
eqstmt: eqexpress | lgcl eqexpress 
eqstmts: eqstmt | eqstmt eqstmts 

if: IF eqstmts THEN nwln
ifexpress: if stmts
else: ELSE nwln
elseexpress: else stmts

ifstmt: ifexpress | ELSE ifexpress
ifstmts: ifstmt | ifstmts ifstmt

cdtnl: ifstmts ENDIF endop | ifstmts elseexpress ENDIF endop

//TODOs: handle nested ifs... I think the current while handles nested whiles but double check that

while: WHILE eqstmts DO nwln
wstmt: while stmts ENDWHILE endop | while cdtnl ENDWHILE endop | while stmts cdtnl ENDWHILE endop

%%

int main()
{
  yyparse();
}
void yyerror (char *msg)
{
  fprintf( stderr, "%s: line %d \n", msg, lineno); 
}
