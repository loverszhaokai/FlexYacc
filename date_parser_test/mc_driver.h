#ifndef __MCDRIVER_HPP__
#define __MCDRIVER_HPP__ 1

#include <cstdint>
#include <string>
#include <vector>

#include "mc_scanner.h"
#include "mc_parser.hh"

namespace MC{

class MC_Driver{
public:
   MC_Driver() = default;

   virtual ~MC_Driver();

   void parse( const char *filename );

   void add_upper();
   void add_lower();
   void add_word( const std::string &word );
   void add_newline();
   void add_char();

   void SetYear(const int _year) { year = _year; }
   void SetMonth(const int _month) { month = _month; }
   void SetDay(const int _day) { day = _day; }
   void SetHour(const int _hour) { hour = _hour; }
   void SetMinute(const int _minute) { minute = _minute; }
   void SetSecond(const int _second) { second = _second; }

   void add_date_year();
   void add_date_month();

   std::ostream& print(std::ostream &stream);

private:
  int year = 0;
  int month = 0;
  int day = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;

   int chars      = 0;
   int words      = 0;
   int lines      = 0;
   int uppercase  = 0;
   int lowercase  = 0;

   std::vector<std::string> dates;

   MC::MC_Parser  *parser  = nullptr;
   MC::MC_Scanner *scanner = nullptr;
};

} /* end namespace MC */
#endif /* END __MCDRIVER_HPP__ */
