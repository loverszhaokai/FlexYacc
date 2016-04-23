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
 * This file contains the unit test of DateParser
 */

#include <iostream>
 
#include "gtest/gtest.h"

#include "date_parser/date_parser.h"
#include "util.h"

TEST(DateParser, DateParser) {
  static const struct DateParserInfo {
    const std::string input;
    const std::vector<std::string> dates;
  } dinfos [] = {
    {
      "",
      {}
    },
    {
      "2016-04-22",
      {
        "2016-04-22",
      }
    },
  };

  for (int i = 0; i < countof(dinfos); i++) {
    const DateParserInfo* cnt_dinfo = &dinfos[i];
    const std::vector<std::string> actual_dates = DateParser(cnt_dinfo->input);

    EXPECT_EQ(cnt_dinfo->dates, actual_dates);

    if (cnt_dinfo->dates != actual_dates) {
      std::cout << "\t expect dates:" << std::endl;
      for (auto item : cnt_dinfo->dates) {
        std::cout << "\t\t " << item << std::endl;
      }

      std::cout << "\t actual dates:" << std::endl;
      for (auto item : actual_dates) {
        std::cout << "\t\t " << item << std::endl;
      }
    }
  }
}
