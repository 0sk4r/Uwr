#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <avr/power.h>
#include <avr/sleep.h>

#define BLINK_DELAY_MS 500

int number = 0;

unsigned int binaryToGray(unsigned int num)
{
  return num ^ (num >> 1);
}

//przerwanie
ISR(INT0_vect)
{
      _delay_ms(300);
      PORTB &= 0x00;
      number++;
      PORTB |= binaryToGray(number);

}

ISR(INT1_vect)
{
      _delay_ms(300);
      PORTB &= 0x00;
      number--;
      PORTB |= binaryToGray(number);

}

ISR(PCINT2_vect)
{
  _delay_ms(300);
  PORTB &= 0x00;
}

int main (void)
{
  //sleep setings
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  sleep_enable();

  //ustawienie pinb1 i pinb2 na wyjscie
  DDRB |= 0xFF;
  //ustawienie portow pind na wejscie
  DDRD &= 0x00;

  PCICR |= _BV(PCIF2);
  PCMSK2 |= _BV(PCINT20);
  EIMSK |= _BV(INT0) | _BV(INT1);
  MCUCR |= _BV(ISC11) | _BV(ISC01);
  sei();        //Enable Global Interrupt


  while (1) {

    sleep_mode();
  }
}
