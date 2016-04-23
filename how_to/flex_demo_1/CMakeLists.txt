cmake_minimum_required(VERSION 3.3)
project(flex_demo_1)

FLEX_TARGET(demo demo.lex ${CMAKE_CURRENT_BINARY_DIR}/demo.cc)

add_executable(flex_demo_1 ${FLEX_demo_OUTPUTS})
target_link_libraries(flex_demo_1 fl)
