#ifndef _CONTROL_TMR0_
#define _CONTROL_TMR0_

#define TMR_STP 0
#define TMR_PRESC_1 1
#define TMR_PRESC_8 2
#define TMR_PRESC_64 3
#define TMR_PRESC_256 4
#define TMR_PRESC_1024 5
#define EXT_CLK_FALL 6 
#define EXT_CLK_RISE 7

/*
Aquest mini-mòdul únicament ha de posar en marxa 
un procés d'interrupcions amb el TMR0
*/

void setup_TMR0();

#endif
