/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     WHILE = 258,
     DO = 259,
     ENDWHILE = 260,
     IF = 261,
     THEN = 262,
     ELSE = 263,
     ENDIF = 264,
     ADD = 265,
     MINUS = 266,
     NUM = 267,
     VAR = 268,
     AND = 269,
     OR = 270,
     NOTEQ = 271,
     EQUAL = 272,
     LTHAN = 273,
     LTOREQ = 274,
     GTHAN = 275,
     GTOREQ = 276,
     ASIGN = 277
   };
#endif
/* Tokens.  */
#define WHILE 258
#define DO 259
#define ENDWHILE 260
#define IF 261
#define THEN 262
#define ELSE 263
#define ENDIF 264
#define ADD 265
#define MINUS 266
#define NUM 267
#define VAR 268
#define AND 269
#define OR 270
#define NOTEQ 271
#define EQUAL 272
#define LTHAN 273
#define LTOREQ 274
#define GTHAN 275
#define GTOREQ 276
#define ASIGN 277




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

