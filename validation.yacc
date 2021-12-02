%{
#include <stdio.h>
#include <string.h>
#define ERR_COLOR "\x1b[31m"

extern int yylex();
void yyerror(char *);

int lineno = 1;
int numval = 0;
int wnum = 0;
int ifnum = 0;
int elsenum = 0;
int currentif = 0;

char varname[20];
char destination[20];
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
ifexpress: ifparams blocks 

elseif: ELSE IF val {printf("\telse%d: \n", elsenum);}
elseifparams: elseif eqstmt THEN nwln {printf("CMP R7\n"); printf("%s else%d\n", branch, ifnum);}
elseifxpress: elseifparams blocks
elseifxpressns: elseifxpress | elseifxpressns elseifxpress

else: ELSE nwln {printf("\telse%d: \n", elsenum);}
elsexpress: else blocks

iestmt: ifexpress ENDIF endop | ifexpress elseifxpressns elsexpress ENDIF endop | ifexpress elsexpress ENDIF endop

//----------------------------------------------------------------
//----------------------------------------------------------------

while: WHILE val {printf("\twtop: "); printf("MOV R8 %s\n", varname);}
whileparams: while eqstmt DO nwln {printf("CMP R7\n"); printf("%s end%d\n", branch, wnum);}
wexpress: whileparams blocks {printf("JMP wtop\n");}
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
