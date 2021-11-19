%{
#include <stdio.h>
#include <string.h>
extern int yylex();
void yyerror(char *);
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

prog: stmts
stmts: stmt eoline | stmt stmts
stmt: val op 
| val eoline
| ifstmt
| wstmt

val: VAR | NUM 
op: ADD | MINUS | ASIGN 
eoline: RETURN | SEMI RETURN

cdtnl: EQUAL | NOTEQ | LTHAN | LTOREQ | GTHAN | GTOREQ 
cdtn: val cdtnl val 
scndcdtn: AND | OR 
cdtnstmt: cdtn | scndcdtn cdtn 
cdtnstmts: cdtnstmt | cdtnstmt cdtnstmt 

if: IF cdtnstmts THEN 
else: ELSE stmts
ifstmt: if stmts ENDIF RETURN | if stmts else ENDIF RETURN

whilecdtn: WHILE cdtnstmts DO 
wstmt: whilecdtn stmts ENDWHILE RETURN | whilecdtn ifstmt ENDWHILE RETURN

%%

int main()
{
  yyparse();
}
void yyerror (char *msg)
{
  extern int yylineno;
  fprintf( stderr, "syntax error in line %d \n", yylineno); 
}