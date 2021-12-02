%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

extern int lineno;
extern int numval;
extern int wnum;
extern int ifnum;
extern char varname[];

%}
%%

"while" {wnum++; return WHILE;}
"do" return DO;
"endwhile" {wnum--; return ENDWHILE;}

"if" {ifnum++; return IF;}
"then" return THEN;
"else" return ELSE;
"endif" {ifnum--; return ENDIF;}

[0-9]+ {numval=atoi(yytext); return NUM;}

[a-zA-Z]+ {strcpy(varname, yytext); return VAR;}

"&&" return AND;
"||" return OR;
"!=" return NOTEQ;
"==" return EQUAL;
"<"  return LTHAN;
"<=" return LTOREQ;
">"  return GTHAN;
">=" return GTOREQ;

"=" return ASIGN;
"+" return ADD;
"-" return MINUS;
";" return SEMI;

" " ;

\n {lineno++; return RETURN; }

. return JUNK;

%%