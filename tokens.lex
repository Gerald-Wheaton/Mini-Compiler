%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

extern int lineno;
extern int numval;
extern int wnum;
extern int ifnum;
extern int elsenum;
extern int currentif;

extern char varname[];
extern char branch[];
extern char errinput[];

%}
%%

"while" {wnum++; return WHILE;}
"do" return DO;
"endwhile" {wnum--; return ENDWHILE;}

"if" {ifnum++; return IF;}
"then" return THEN;
"else" {elsenum++; return ELSE;}
"endif" {return ENDIF;}

[0-9]+ {numval=atoi(yytext); return NUM;}

[a-zA-Z]+ {strcpy(varname, yytext); return VAR;}

"!=" {strcpy(branch, "BNE"); return NOTEQ;}
"==" {strcpy(branch, "BEQ"); return EQUAL;}
"<"  {strcpy(branch, "BLT"); return LTHAN;}
"<=" {strcpy(branch, "BLE"); return LTOREQ;}
">"  {strcpy(branch, "BGT"); return GTHAN;}
">=" {strcpy(branch, "GTE"); return GTOREQ;}

"=" return ASIGN;
"+" return ADD;
"-" return MINUS;
";" return SEMI;

" " ;

\n {lineno++; return RETURN; }

. {strcpy(errinput, yytext); return JUNK;}

%%