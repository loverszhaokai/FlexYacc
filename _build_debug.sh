#!/bin/sh

mkdir -p build-cmake/Debug
rm ./build-cmake/Debug/*unittest

cmake -H. -B./build-cmake/Debug/obj -DCMAKE_BUILD_TYPE=Debug -DCMAKE_BUILD_ASAN_TYPE=1
#-DCMAKE_CXX_COMPILER=/usr/local/clang+llvm-3.8.0-linux-x86_64-centos6/bin/clang++
cmake --build ./build-cmake/Debug/obj -- -j4
