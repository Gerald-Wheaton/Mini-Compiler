%{
#include <stdio.h>
#include <string.h

extern int yylex();
void yyerror(char *);
%}

%token WHILE DO ENDWHILE 
IF THEN ELSE ENDIF 
ADD MINUS
NUM VAR 
AND OR 
NOTEQ EQUAL LTHAN LTOREQ GTHAN GTOREQ ASIGN 

%%

prog: stmts

stmts: stmt | stmt stmt

stmt: VAR EQUAL NUM op NUM

cstmt: VAR compare VAR | VAR compare NUM | NUM compare VAR

compare: EQUAL | NOTEQ | LTHAN | LTOREQ | GTHAN | GTOREQ

op: ADD | MINUS 

wstmt: WHILE cstmt DO

%%
int main()
{
  yyparse();
}
void yyerror (char *msg)
{
  printf ("Oops, syntax error!!!!!!\n");
}