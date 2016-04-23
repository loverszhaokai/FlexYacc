%{

  #include <stdio.h>
  extern "C" int yylex();
%}


%%
[0123456789]+         printf("This is a number!\n");
[a-zA-Z][a-zA-Z0-9]*  printf("This is a word!\n");
%%
