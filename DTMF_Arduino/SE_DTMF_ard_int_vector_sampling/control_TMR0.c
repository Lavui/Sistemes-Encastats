#include <inttypes.h>
#include <avr/io.h>
#include "control_TMR0.h"

void setup_TMR0(){
  TCCR0A=0x02;         //Pin timer desconectat de sortida, mode CTC
  TCCR0B=TMR_PRESC_256;  //Pre-escaler 
  OCR0A=255;            //el període en us és (OCR0A+1)/2...
  TIMSK0=0x02;         //Bit 1 – OCIE0A: Timer/Counter0 
                       //Output Compare Match A Interrupt Enable
}

