#include <inttypes.h>
#include <avr/io.h>
#include "tmr0.h"

void setup_tmr0(uint8_t ocr0a,uint16_t tmr0_pre){
  TCCR0A=0x02;//CTC mode: TOP=OCRA 
  TIMSK0=0x02;//Bit 1 – OCIE0A: Timer/Counter0 Output Compare Match A Interrupt Enable
  OCR0A=ocr0a;//TOP value

  //tmr0_pre 1,default=8,64,256,1024
  //TMR0=prescaler*(ocr0a+1)*T_clk
  switch (tmr0_pre){
  case 1:TCCR0B=1;break;
  case 8:TCCR0B=2;break;
  case 64:TCCR0B=3;break;
  case 256:TCCR0B=4;break;
  case 1024:TCCR0B=5;break;
  default:TCCR0B=2;break;
  }
}
