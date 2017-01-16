#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <avr/power.h>
#include <avr/sleep.h>

#define BLINK_DELAY_MS 500

//przerwanie
ISR(INT0_vect)
{
  
  unsigned char i;

  if(!(PIND & (1 << 7))){
    PORTB |= 0xFF;
  }
  if(!(PIND & (1 << 6))){
    PORTB |= 0x00;
  }
  
  for (i = 0; i < 5; i++)
  {
    PORTB |= (1 << PB2);
    _delay_ms(BLINK_DELAY_MS);
    PORTB &= ~(1 << PB2);
    _delay_ms(BLINK_DELAY_MS);
  }

}

int main (void)
{
  //sleep setings
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  sleep_enable();
  
  /* set pin 5 of PORTB for output*/
  DDRB |= (1 << PB2);
  DDRB |= (1 << PB1);
  DDRD &= 0x00;


  EIMSK |= _BV(INT0);
  MCUCR |= _BV(ISC11) | _BV(ISC10) | _BV(ISC01) | _BV(ISC00);
  sei();        //Enable Global Interrupt


  while (1) {
    //if(!(PIND & (1 << 7)))
    PORTB |= (1 << PB1);
    _delay_ms(BLINK_DELAY_MS);
    PORTB &= ~(1 << PB1);
    _delay_ms(BLINK_DELAY_MS);
    //put in sleep mode 
    sleep_mode();
  }
}
