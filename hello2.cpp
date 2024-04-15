#include <iostream>
#include "picojson.h"

int main(int argc, char **argv)
{
  std::string str;

  picojson::array a;
  while( std::cin >> str ) {
    a.push_back(picojson::value(str);
  }
  std::cout << "Hello2[" << picojson::value(a) << "]" << std::endl;
  return 0;
}
// updated
