%skeleton "lalr1.cc"
%require  "3.0"
%debug 
%defines 
%define api.namespace {MC}
%define parser_class_name {MC_Parser}

%code requires{
   namespace MC {
      class MC_Driver;
      class MC_Scanner;
   }

// The following definitions is missing when %locations isn't used
# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

}

%parse-param { MC_Scanner  &scanner  }
%parse-param { MC_Driver  &driver  }

%code{
   #include <iostream>
   #include <cstdlib>
   #include <fstream>
   
   /* include for all driver functions */
   #include "mc_driver.h"

#undef yylex
#define yylex scanner.yylex
}

%define api.value.type variant
%define parse.assert

%token               END    0     "end of file"
%token               UPPER
%token               LOWER
%token <std::string> WORD
%token               NEWLINE
%token               CHAR

%token <int>         YEAR
%token <int>         MONTH
%token <int>         DAY

%token <int>         INT_0
%token <int>         INT_1_9
%token <int>         INT_00
%token <int>         INT_01_09
%token <int>         INT_10_12
%token <int>         INT_13_24
%token <int>         INT_25_31
%token <int>         INT_32_60

%locations

%%

list_option : END | list END;

list
  : date
  | list date
  ;

date
  : YEAR { driver.add_date($1); }
  | MONTH   { driver.add_date($1); }
  | INT_0   { driver.add_date($1); }
  | INT_1_9   { driver.add_date($1); }
  | INT_00   { driver.add_date($1); }
  | INT_01_09   { driver.add_date($1); }
  | INT_10_12   { driver.add_date($1); }
  | INT_13_24   { driver.add_date($1); }
  | INT_25_31   { driver.add_date($1); }
  | INT_32_60   { driver.add_date($1); }
  | LOWER   { driver.add_lower(); }
  | WORD    { driver.add_word( $1 ); }
  | NEWLINE { driver.add_newline(); }
  | CHAR    { driver.add_char(); }
  ;

%%


void 
MC::MC_Parser::error( const location_type &l, const std::string &err_message )
{
   std::cerr << "Error: " << err_message << " at " << l << "\n";
}
