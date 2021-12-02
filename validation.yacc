%{
#include <stdio.h>
#include <string.h>
extern int yylex();
void yyerror(char *);

int lineno = 1;
int numval = 0;
int wnum = 0;
int ifnum = 0;
int currentif = 0;

char varname[20];
char destination[20];
char branch[10];

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
block: mexpr | iestmt {printf("\tendif:\n");} | wstmt {printf("\tendw:\n");}

//----------------------------------------------------------------
//----------------------------------------------------------------

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
val: VAR
nwln: RETURN
endop: SEMI RETURN

//----------------------------------------------------------------
//----------------------------------------------------------------

equalities: EQUAL | NOTEQ | LTHAN | LTOREQ |  GTHAN | GTOREQ 
eqxpress: equalities val {printf("MOV R7 %s\n", varname);} | 
  equalities num {printf("MOV R7 %d\n", numval);}
eqstmt: eqxpress

//----------------------------------------------------------------
//----------------------------------------------------------------

if: IF val {printf("MOV R8 %s\n", varname);}
ifparams: if eqstmt THEN nwln {printf("CMP R7\n"); printf("%s else%d\n", branch, ifnum); currentif = ifnum;}
ifexpress: ifparams blocks {printf("\telse%d: \n", currentif);}

elseif: ELSE IF val
elseifparams: elseif eqstmt THEN nwln
elseifexpress: elseifparams blocks
elseifexpressns: elseifexpress | elseifexpressns elseifexpress

else: ELSE nwln 
elsexpress: else blocks {printf("\telse%d: \n", currentif);}
/* 
iexpressns: iexpress | iexpressns iexpress
iexpress: ifexpress | ELSE ifexpress {printf("\telse%d: \n", currentif); printf("MOV R8 %s\n", varname);} */

iestmt: ifexpress ENDIF endop | ifexpress elseifexpressns elsexpress ENDIF endop | ifexpress elsexpress ENDIF endop

//cdtnl: ifstmt ENDIF endop | ifstmt elsexpress ENDIF endop

//----------------------------------------------------------------
//----------------------------------------------------------------

while: WHILE val {printf("\twtop: "); printf("MOV R8 %s\n", varname);}
whileparams: while eqstmt DO nwln {printf("CMP R7\n"); printf("%s end%d\n", branch, wnum);}
wexpress: whileparams blocks {printf("JMP wtop\n");}
wstmt: wexpress ENDWHILE endop

%%

int main()
{
  yyparse();
}
void yyerror (char *msg)
{
  fprintf( stderr, "%s: line %d \n", msg, lineno); 
}
