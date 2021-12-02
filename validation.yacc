%{
#include <stdio.h>
#include <string.h>
#define ERR_COLOR "\x1b[31m"

extern int yylex();
void yyerror(char *);

int lineno = 1;
int numval = 0;
int openclause = 0;
int elsenum = 0;

char varname[20];
char branch[10];
char errinput[10];

%}

%token WHILE DO ENDWHILE
IF THEN ELSE ENDIF
ADD MINUS
NUM VAR
ASIGN
NOTEQ EQUAL LTHAN LTOREQ GTHAN GTOREQ
SEMI
RETURN
JUNK

%%

prog: blocks
blocks: block | blocks block
block: mexpr | iestmt {printf("end%d:\n", openclause);} | wstmt {printf("end%d:\n", openclause);}

//----------------------------------------------------------------
//----------------------------------------------------------------

mexpr: asign stmts endop {printf("\tMOV %s R1\n", varname);}
asign: VAR ASIGN
stmts: stmt | stmts stmt
stmt: ADD val {printf("\tADD R1, %s\n", varname);} | 
  MINUS val {printf("\tSUB R1, %s\n", varname);} | 
  val {printf("\tMOV R1, %s\n", varname);} | 
  ADD num {printf("\tADD R1, %d\n", numval);} | 
  MINUS num {printf("\tSUB R1, %d\n", numval);} | 
  num {printf("\tMOV R1, %d\n", numval);}

//----------------------------------------------------------------
//----------------------------------------------------------------

equalities: EQUAL | NOTEQ | LTHAN | LTOREQ |  GTHAN | GTOREQ 
eqxpress: equalities val {printf("\tMOV R7 %s\n", varname);} | 
  equalities num {printf("\tMOV R7 %d\n", numval);}
eqstmt: eqxpress

//----------------------------------------------------------------
//----------------------------------------------------------------

if: IF val {printf("\tMOV R8 %s\n", varname);}
ifparams: if eqstmt THEN nwln {printf("\tCMP R7\n"); printf("\t%s else%d\n", branch, openclause);}
ifexpress: ifparams blocks 

elseif: ELSE IF val {printf("else%d: \n", elsenum);}
elseifparams: elseif eqstmt THEN nwln {printf("\tCMP R7\n"); printf("\t%s else%d\n", branch, openclause);}
elseifxpress: elseifparams blocks
elseifxpressns: elseifxpress | elseifxpressns elseifxpress

else: ELSE nwln {printf("else%d: \n", elsenum);}
elsexpress: else blocks

iestmt: ifexpress ENDIF endop | ifexpress elseifxpressns elsexpress ENDIF endop | ifexpress elsexpress ENDIF endop

//----------------------------------------------------------------
//----------------------------------------------------------------

while: WHILE val {printf("wtop%d: ", openclause); printf("MOV R8 %s\n", varname);}
whileparams: while eqstmt DO nwln {printf("\tCMP R7\n"); printf("\t%s end%d\n", branch, openclause);}
wexpress: whileparams blocks {printf("\tJMP wtop%d\n", openclause);}
wstmt: wexpress ENDWHILE endop

//----------------------------------------------------------------
//----------------------------------------------------------------

num: NUM
val: VAR
nwln: RETURN
endop: SEMI RETURN

%%

int main()
{
  yyparse();
}
void yyerror (char *msg)
{
  fprintf( stderr, ERR_COLOR "%s line %d\n", msg, lineno); 
  if(strcmp(errinput, "")) {
    printf(ERR_COLOR "  invalid character -> \"%s\"\n", errinput);
  }
}
