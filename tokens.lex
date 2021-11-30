%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
extern int lineno;
%}
%%

"while" {printf("WHILE "); return WHILE;}
"do" {printf("DO "); return DO;}
"endwhile" {printf("ENDWHILE "); return ENDWHILE;}

"if" {printf("IF "); return IF;}
"then" {printf("THEN "); return THEN;}
"else" {printf("ELSE "); return ELSE;}
"endif" {printf("ENDIF "); return ENDIF;}

[0-9]+ {printf("NUM "); return NUM;}

[a-zA-Z]+ {printf("VAR "); return VAR;}

"&&" {printf("AND "); return AND;}
"||" {printf("OR "); return OR;}
"!=" {printf("NOTEQ "); return NOTEQ;}
"==" {printf("EQUAL "); return EQUAL;}
"<"  {printf("LTHAN "); return LTHAN;}
"<=" {printf("LTOREQ "); return LTOREQ;}
">"  {printf("GTHAN "); return GTHAN;}
">=" {printf("GTOREQ "); return GTOREQ;}

"=" {printf("ASIGN "); return ASIGN;}
"+" {printf("ADD "); return ADD;}
"-" {printf("MINUS "); return MINUS;}
";" {printf("SEMI "); return SEMI;}

" " ;

\n {printf("RETURN \n"); lineno++; return RETURN; }

. {printf("JUNK "); return JUNK;}

%%