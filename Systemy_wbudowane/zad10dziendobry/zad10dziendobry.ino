#include <PCM.h>

const unsigned char sample[] PROGMEM = {
    0x62, 0x69, 0x6e, 0x61, 0x72, 0x79, 
  0x64, 0x61, 0x74, 0x61
  };

void setup()
{
  startPlayback(sample, sizeof(sample));
}

void loop()
{
}


