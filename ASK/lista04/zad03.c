#include "stdint.h"

uint32_t ChangeEndianness(uint32_t value)
{
    uint32_t result = 0;
    result |= (value & 0x000000FF) << 24;
    result |= (value & 0x0000FF00) << 8;
    result |= (value & 0x00FF0000) >> 8;
    result |= (value & 0xFF000000) >> 24;
    return result;
}

int main(){
  uint32_t val = 12345;

  uint32_t x = ChangeEndianness(val);

  return 0;
}
