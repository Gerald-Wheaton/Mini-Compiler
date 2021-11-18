%{
#include <stdio.h>
#include <string.h>

extern int yylex();
void yyerror(char *);
%}

%token WHILE DO  ENDWHILE
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

prog: stmts
stmts: stmt endop | stmt stmts
stmt: val op | val endop
val: VAR | NUM
op: ADD | MINUS | ASIGN
endop: SEMI

/*cdtnl: NOTEQ | EQUAL | LTHAN | LTOREQ | GTHAN | GTOREQ
cdtn: val cdtnl val 
scndcdtn: AND | OR
cdtnstmt: cdtn | scndcdtn cdtn
cdtnstmts: cdtnstmt | cdtnstmt cdtnstmt
wstmt: WHILE cdtn DO | cdtnstmts DO*/

%%

int main()
{
  yyparse();
}
void yyerror (char *msg)
{
  printf ("\n%s\n", msg);
}