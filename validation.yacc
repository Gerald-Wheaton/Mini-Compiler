%{
#include <stdio.h>
#include <string.h>
extern int yylex();
void yyerror(char *);

int lineno = 1;
int numval = 0;
int wnum = 0;
int ifnum = 0;

char varname[20];
char destination[20];

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

prog: blocks
blocks: block | blocks block
block: mexpr | cdtnl | wstmt

//----------------------------------------------------------------
//----------------------------------------------------------------

mexprs: mexpr | mexprs mexpr
mexpr: asign stmts endop {printf("MOV %s R1\n", varname);}
asign: VAR ASIGN
stmts: stmt | stmts stmt
stmt: ADD val {printf("ADD R1, %s\n", varname);} | 
  MINUS val {printf("SUB R1, %s\n", varname);} | 
  val {printf("MOV R1, %s\n", varname);} | 
  ADD num {printf("ADD R1, %d\n", numval);} | 
  MINUS num {printf("SUB R1, %d\n", numval);} | 
  num {printf("MOV R1, %d\n", numval);}

num: NUM
val: VAR //| NUM 
//op: ADD | MINUS
nwln: RETURN
endop: SEMI RETURN

//----------------------------------------------------------------
//----------------------------------------------------------------

equalities: EQUAL | NOTEQ | LTHAN | LTOREQ | GTHAN | GTOREQ 
lgcl: AND | OR 
eqxpress: val equalities val | val equalities num
eqstmt: eqxpress | lgcl eqxpress 
eqstmts: eqstmt | eqstmts eqstmt

//----------------------------------------------------------------
//----------------------------------------------------------------

if: IF eqstmts THEN nwln
ifexpress: if mexprs
else: ELSE nwln
elsexpress: else mexprs

ifstmt: ifexpress | ELSE ifexpress
ifstmts: ifstmt | ifstmts ifstmt

cdtnl: ifstmts ENDIF endop {printf("valid if-then statement \n");}
| ifstmts elsexpress ENDIF endop {printf("valid if-then-else statement \n");}

//----------------------------------------------------------------
//----------------------------------------------------------------

while: WHILE eqstmts DO nwln
wstmt: while blocks ENDWHILE endop {printf("valid while loop \n");}

%%

int main()
{
  yyparse();
}
void yyerror (char *msg)
{
  fprintf( stderr, "%s: line %d \n", msg, lineno); 
}
