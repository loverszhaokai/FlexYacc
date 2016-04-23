/*
 * DateParser
 * --------------------------------
 *
 * Copyright 2016 Kai Zhao <loverszhao@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * This file contains the util functions
 */

#ifndef _DATE_PARSER_SRC_UTIL_H_
#define _DATE_PARSER_SRC_UTIL_H_

#define ARRARY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

// Notice: the ARRAY_SIZE() can accept a pointer, which is wrong.
// Here is a new macro to count array size which only accept array
// Reference: https://blogs.msdn.microsoft.com/the1/2004/05/07/how-would-you-get-the-count-of-an-array-in-c-2/

template <typename T, size_t N>
char (&_ArraySizeHelper(T (&array) [N]) ) [N];

#define countof(array) sizeof(_ArraySizeHelper(array))

#endif
