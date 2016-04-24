cmake_minimum_required(VERSION 3.3)
project(FlexYacc)

# usage
# debug
# 1 make output dir: e.g. build-cmake/Debug
# 3 exec: cmake -H. -B./build-cmake/Debug/obj -DCMAKE_BUILD_TYPE=Debug
# 3.1 build with asan and debug: cmake -H. -B./build-cmake/Debug/obj -DCMAKE_BUILD_TYPE=Debug -DCMAKE_BUILD_ASAN_TYPE=1
# 4 build target: cmake --build ./build-cmake/Debug/obj --target ** -- -j4
# 5 clean: cmake --build ./build-cmake/Debug --target clean


find_package(BISON)
find_package(FLEX)

set(CMAKE_C_COMPILER "/usr/bin/gcc")
set(CMAKE_CXX_COMPILER "/usr/bin/g++")

IF(CMAKE_BUILD_TYPE MATCHES Debug)
    set(CMAKE_VERBOSE_MAKEFILE ON)
ENDIF(CMAKE_BUILD_TYPE MATCHES Debug)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build-cmake/${CMAKE_BUILD_TYPE})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build-cmake/${CMAKE_BUILD_TYPE})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build-cmake/${CMAKE_BUILD_TYPE}/lib)

add_subdirectory(date_parser)
add_subdirectory(date_parser_test)
add_subdirectory(how_to)
add_subdirectory(simple_wc_example)
add_subdirectory(third_party)
