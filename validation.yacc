%{
#include <stdio.h>
#include <string.h>
extern int yylex();
void yyerror(char *);

int lineno = 0;
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

prog: blocks
blocks: block | block blocks
block: cdtnl | wstmt | stmts cdtnl | stmts wstmt
stmts: stmt | stmts stmt
stmt: val op | val eoline | err
err: JUNK

val: VAR | NUM 
op: ADD | MINUS | ASIGN 
eoline: RETURN | SEMI RETURN

equalities: EQUAL | NOTEQ | LTHAN | LTOREQ | GTHAN | GTOREQ 
lgcl: AND | OR 
eqexpress: val equalities val
eqstmt: eqexpress | lgcl eqexpress 
eqstmts: eqstmt | eqstmt eqstmts 

else: ELSE eoline
ifexpress: IF eqstmts THEN eoline
elseexpress: else stmts ENDIF eoline

cdtnl: ifexpress stmts ENDIF eoline | ifexpress eoline stmts elseexpress

//still need to handle nested if...... I think the current while handles nested whiles but double check that


whileexpress: WHILE eqstmts DO eoline
wstmt: whileexpress stmts ENDWHILE eoline | whileexpress cdtnl ENDWHILE eoline | whileexpress stmts cdtnl ENDWHILE eoline

%%

int main()
{
  yyparse();
}
void yyerror (char *msg)
{
  fprintf( stderr, "syntax error in line %d \n", lineno); 
}
