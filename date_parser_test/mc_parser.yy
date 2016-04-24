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

// Key symbols
%token <std::string> SYM_DASH     "-"

// Numbers
%token <int>         INT_YEAR     "1970~2999 "
%token <int>         INT_0        "0"
%token <int>         INT_1_12     "1~12"
%token <int>         INT_13_24    "13~24"
%token <int>         INT_25_31    "25~31"
%token <int>         INT_32_59    "32~59"

%type <int> int_1_24
%type <int> int_0_24
%type <int> int_1_31
%type <int> int_0_59

%locations

%%

list_option : END | list END;

list
  : date
  | list date
  ;

date
  : INT_YEAR SYM_DASH month
  {
    printf("\t==date_1\n");
    driver.SetYear($1);
    driver.add_date_year();
  }
  | ignored
  ;

month
  : INT_1_12 SYM_DASH day
  {
    driver.SetMonth($1);
  }
  ;

day
  : int_1_31
  {
    driver.SetDay($1);
  }
  ;

hour
  : int_0_24
  {
    driver.SetHour($1);
  }
  ;

int_1_24
  : INT_1_12
  {
    $$ = $1;
  }
  | INT_13_24
  {
    $$ = $1;
  }
  ;

int_0_24
  : INT_0
  {
    $$ = $1;
  }
  | int_1_24
  {
    $$ = $1;
  }
  ;

int_1_31
  : int_1_24
  {
    $$ = $1;
  }
  | INT_25_31
  {
    $$ = $1;
  }
  ;

int_0_59
  : INT_0
  {
    $$ = $1;
  }
  | int_1_31
  {
    $$ = $1;
  }
  | INT_32_59
  {
    $$ = $1;
  }
  ;

ignored
  :
  | CHAR {}
  | INT_YEAR INT_1_12
  {
    printf("\t\t Ignored: year=%d int_1_12=%d\n", $1, $2);
  }
  | INT_1_12
  {
    printf("\t\t Ignored: int_1_12=%d\n", $1);
  }
  | INT_13_24
  | INT_25_31
  | INT_32_59
  | NEWLINE { driver.add_newline(); }
  | INT_0

  | SYM_DASH
  {
    printf("\t==date -- SYM_DASH\n");
  }
  ;

%%


void 
MC::MC_Parser::error( const location_type &l, const std::string &err_message )
{
   std::cerr << "Error: " << err_message << " at " << l << "\n";
}
