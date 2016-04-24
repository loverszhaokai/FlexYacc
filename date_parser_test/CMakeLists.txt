cmake_minimum_required(VERSION 3.3)
project(date_parser_test)

include_directories(. ${CMAKE_CURRENT_BINARY_DIR})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

BISON_TARGET(mc_parser mc_parser.yy ${CMAKE_CURRENT_BINARY_DIR}/mc_parser.cc)
FLEX_TARGET(mc_lexer mc_lexer.l ${CMAKE_CURRENT_BINARY_DIR}/mc_lexer.cc)

ADD_FLEX_BISON_DEPENDENCY(mc_lexer mc_parser)

set(SOURCE_FILES
    main.cc
    mc_driver.cc
    mc_driver.h
    mc_scanner.h)

add_executable(date_parser_test ${SOURCE_FILES}
               ${BISON_mc_parser_OUTPUTS}
               ${FLEX_mc_lexer_OUTPUTS})
