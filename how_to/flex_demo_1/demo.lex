%{

  #include <stdio.h>
  extern "C" int yylex();
%}


%%
stop printf("Stop command received\n");
start printf("Start command received\n");
%%
