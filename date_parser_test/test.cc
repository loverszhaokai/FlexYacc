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
 * This file contains the test of DateParser
 */

#include <stdio.h>

#include <fstream>
#include <iostream>
#include <queue>
#include <sstream>
#include <string>

#include "test.h"
#include "time_util.h"
#include "mc_driver.h"

using std::cout;
using std::endl;
using std::fstream;
using std::queue;
using std::string;
using std::stringstream;

extern fstream ofs;

static vector<string> in_files, out_files;

int TEST_date_parser()
{
	TimeUtil tu;

	if (0 != get_files("date_parser_test/test", &in_files, &out_files))
		return -1;
	for (int iii = 0; iii < in_files.size(); iii++) {
		const string in_file_name = in_files[iii];

		// Run
		tu.restart();

    MC::MC_Driver driver;
    driver.parse(in_file_name.c_str());

		tu.stop();

		ofs.open(OUTPUT_FILE, fstream::out);
    driver.print(ofs);
		ofs.close();

		if (0 != compare_file(out_files[iii], OUTPUT_FILE)) {
			cout << __FUNCTION__ << " case " << iii + 1 << " failed  :" << endl;
			return -1;
		}

	}
	cout << __FUNCTION__ << "  total run time=" << tu.get_total_run_time() << "ms" << endl;

	return 0;
}

int main()
{
	TimeUtil tu;
	if (0 != TEST_date_parser())
		return -1;

  cout << "\n\tDateParser: PASSED\n\n";
	cout << __FILE__ << "  total run time=" << tu.get_run_time() << "ms" << endl;

	return 0;
}
