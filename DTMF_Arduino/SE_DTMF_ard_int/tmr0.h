#ifndef _TMR0_
#define _TMR0_

void setup_tmr0(uint8_t ocr0a,uint16_t tmr0_pre);
//tmr0_pre 1,default=8,64,256,1024
//TMR0=prescaler*(ocr0a+1)*T_clk
#endif
