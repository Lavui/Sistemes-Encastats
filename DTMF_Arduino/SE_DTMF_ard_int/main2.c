#include <avr/interrupt.h>
#include "adc.h"
#include "tmr0.h"
#include "serial_device.h"
#include <stdio.h>

#include "pwm_tmr2.h"
volatile uint8_t estat=1;
volatile int n;
int flag;
volatile int f;
float temps;
volatile int cper=0;

/********************************************
                Clock measurement
---------------------------------------------
This program takes samples from the analog
input A5 of the Ardiuno UNO Board.
The conversion time is 13/fadc_clk, fadc_clk=16e6/adc_pre.

With the 8 most significant bits
it updates the PWM output at terminal ~3 or ~11.

An interrupt is activated each 50us (ocr0a=99, tmr0_pre=8)

The digital output PD4 is set to '1'
at the beginning of the ISR
and to '0' at the end.

26 September 2014
*********************************************/
static int uart_putchar(char c, FILE *stream);
static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL,_FDEV_SETUP_WRITE);
static int uart_putchar(char c, FILE *stream){
  if (c == '\n')
    uart_putchar('\r', stream);
  loop_until_bit_is_set(UCSR0A, UDRE0);
  UDR0 = c;
  return 0;
}


void setup(){
  setup_ADC(5,5,16);//(adc_input,v_ref,adc_pre)
  //adc_input (0-5 (default=5),8 Tª, 14 1.1V, 15 GND 
  //v_ref 0 (AREF), 1(1.1V), default=5 (5V)
  //adc_pre 2,4,8,16(default),32,64,128
  setup_tmr0(99,8);//(ocr0a, tmr0_pre)
  //tmr0_pre 1,default=8,64,256,1024
  //TMR0=prescaler*(ocr0a+1)*T_clk
  setup_pwm_tmr2(11);//(pwm_out) 3,default=11
  DDRD |=(1<<4);//pin 4 Arduino as an output. It shows sampling period (period) and ISR execution time (pulse wide)
  DDRD |=(1<<5);//pin  Arduino as an output. It shows sampling period (period) and ISR execution time (pulse wide)
  serial_init();  
  stdout = &mystdout;
  sei();

}



int main(void){
	float temps=0;
	int f=0;
  	setup();
	printf("htgfthngf");
	while(1){
		if (cper=1){
			cli();
			printf("%f\n",n);
			temps=((double)n/20000);//en ms -->tot i que la f ja la 			coneixem...
			f=n/temps;
			
			n=0;
			cper=0;
			//reniciar timer0 preescaler
			//comensar la lectura de una primera mostra
			sei();
		}
	}

}

ISR(TIMER0_COMPA_vect){
   PORTD |= (1<<PD4);
   uint8_t value=read8_ADC();
   start_ADC();
//Implementem maquina d'estats.


	switch (estat) {
		case 1 :
			if (value < 119){
				estat=2;
				PORTD &= ~(1<<PD5);}
				n++;

			break;
				
		case 2 :
			//sum++;
			if (value > 135){
				PORTD |= (1<<PD5);
				estat=1;
				cper=1;
			break;
				
			}
}
	

	
   set_pwm_tmr2(value);
   PORTD &= ~(1<<PD4);
}

