cmake_minimum_required(VERSION 3.3)
project(yacc_demo_2)

BISON_TARGET(demo_parser demo.y ${CMAKE_CURRENT_BINARY_DIR}/parser.c)
FLEX_TARGET(demo_scanner demo.lex ${CMAKE_CURRENT_BINARY_DIR}/lexer.c)

ADD_FLEX_BISON_DEPENDENCY(demo_scanner demo_parser)

add_executable(yacc_demo_2 ${BISON_demo_parser_OUTPUTS} ${FLEX_demo_scanner_OUTPUTS})
