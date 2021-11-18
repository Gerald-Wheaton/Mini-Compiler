#!/bin/bash
lex tokens.lex

yacc -d validation.yacc

cc y.tab.c lex.yy.c -ll -ly