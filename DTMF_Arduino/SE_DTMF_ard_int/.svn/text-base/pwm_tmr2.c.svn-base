#include <stdio.h>
#include <stdint.h>
#include <avr/io.h>
#include "pwm_tmr2.h"

void setup_pwm_tmr2(uint8_t pwm_out){
  // pwm output values:3,11
  switch (pwm_out){
  case 3:
    DDRD |= (1 << DDD3);
    TCCR2A=0b00100011;//OC2B(b5-b4): Fast PWM(b1-b0)
    break;
 case 11:
    DDRB |= (1 << DDB3);
    TCCR2A=0b10000011;//OC2A(b7-b6) : Fast PWM(b1-b0)
    break;
  default:
    DDRB |= (1 << DDB3);
    TCCR2A=0b10000011;//OC2A(b7-b6) : Fast PWM(b1-b0)
    break;
  }
  TCCR2B=0b00000001;//prescaling(b2-b1-b0, freq=clk/256 = 62500, TOP=0xFF(b3)
}

void set_pwm_tmr2(uint8_t value){
  OCR2A=value;//OC2A:
  OCR2B=value;//OC2B:
}
