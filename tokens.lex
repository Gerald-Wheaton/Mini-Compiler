%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
extern int lineno;
%}
%%

"while" return WHILE;
"do" return DO;
"endwhile" return ENDWHILE;

"if" return IF;
"then" return THEN;
"else" return ELSE;
"endif" return ENDIF;

[0-9]+ return NUM;

[a-zA-Z]+ return VAR;

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