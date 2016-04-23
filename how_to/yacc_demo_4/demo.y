%{
#include <stdio.h>
#include <string.h>

extern int yyparse ();
extern int yylex ();

char* heater;
int yydebug=1;

void yyerror(const char *str)
{
  fprintf(stderr,"error: %s\n",str);
}

int yywrap()
{
  return 1;
}

main()
{
  yyparse();
}

%}

%token TOKHEATER TOKHEAT TOKTARGET TOKTEMPERATURE

%union
{
int number;
char *string;
}

%token <number> STATE
%token <number> NUMBER
%token <string> WORD

%%
commands: /* empty */
        | commands command
        ;

command:
        heater_select
        |
        target_set
        ;

heater_select:
        TOKHEATER WORD
        {
          printf("\tSelected heater '%s'\n", $2);
          heater = $2;
        }
        ;

target_set:
        TOKTARGET TOKTEMPERATURE NUMBER
        {
          printf("\tHeater '%s' temperature set to: %d\n", heater, $3);
        }
        ;
%%
