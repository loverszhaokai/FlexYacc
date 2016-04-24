%{
#include <iostream>
/* C++ string header, for string ops below */
#include <string>

/* Implementation of yyFlexScanner */ 
#include "mc_scanner.h"
#undef  YY_DECL
#define YY_DECL int MC::MC_Scanner::yylex(MC::MC_Parser::semantic_type * const lval, MC::MC_Parser::location_type *location)

/* typedef to make the returns for the tokens shorter */
typedef MC::MC_Parser::token token;

/* define to keep from re-typing the same code over and over */
#define STOKEN( x ) ( new std::string( x ) )

/* define yyterminate as this instead of NULL */
#define yyterminate() return( token::END )

/* msvc2010 requires that we exclude this header file. */
#define YY_NO_UNISTD_H

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

%option debug
%option nodefault
%option yyclass="MC::MC_Scanner"
%option noyywrap
%option c++

%%
%{          // Code executed at the beginning of yylex
            yylval = lval;
%}

\- {
    std::cout << "Find keyword:-" << "\t text=" << yytext << "||\n";
    yylval->build<std::string>( yytext );
    return( token::SYM_DASH );
  }

\: {
    std::cout << "Find keyword::" << "\t text=" << yytext << "||\n";
    yylval->build<std::string>( yytext );
    return( token::SYM_COLON );
  }

19[7-9][0-9] {
               std::cout << "Find keyword:19[7-9][0-9]" << "\t text=" << yytext << "||\n";
               yylval->build<int>() = atoi( yytext );
               return( token::INT_YEAR );
             }

2[0-9][0-9][0-9] {
                   std::cout << "Find keyword:2[0-9][0-9][0-9]" << "\t text=" << yytext << "||\n";
                   yylval->build<int>() = atoi( yytext );
                   return( token::INT_YEAR );
                 }

[4-5][0-9] {
             std::cout << "Find keyword:[4-5][0-9]" << "\t text=" << yytext << "||\n";
             yylval->build<int>() = atoi( yytext );
             return( token::INT_32_59 );
           }

3[3-9] {
         std::cout << "Find keyword:3[3-9]" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_32_59 );
       }

3[0-1] {
         std::cout << "Find keyword:3[0-1]" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_25_31 );
       }

2[5-9] {
         std::cout << "Find keyword:2[5-9]" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_25_31 );
       }

2[0-4] {
         std::cout << "Find keyword:2[0-4]" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_13_24 );
       }

1[3-9] {
         std::cout << "Find keyword:1[3-9]" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_13_24 );
       }

1[0-2] {
         std::cout << "Find keyword:1[0-2]" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_1_12 );
       }

0[1-9] {
         std::cout << "Find keyword:0[1-9]" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_1_12 );
       }

[1-9] {
         std::cout << "Find keyword:[1-9]" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_1_12 );
       }

00 {
     std::cout << "Find keyword:00" << "\t text=" << yytext << "||\n";
     yylval->build<int>() = atoi( yytext );
     return( token::INT_0 );
   }

0 {
    std::cout << "Find keyword:0" << "\t text=" << yytext << "||\n";
    yylval->build<int>() = atoi( yytext );
    return( token::INT_0 );
  }

[0-9]+ {
         std::cout << "Find keyword:[0-9]+" << "\t text=" << yytext << "||\n";
         yylval->build<int>() = atoi( yytext );
         return( token::INT_OTHERS );
       }

\n          {
               // Update line number
               std::cout << "Find keyword:NEWLINE" << "\t text=" << yytext << "||\n";
               loc->lines();
               return( token::NEWLINE );
            }

.           {}
%%


