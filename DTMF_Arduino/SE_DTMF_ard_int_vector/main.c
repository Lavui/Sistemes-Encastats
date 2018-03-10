#include <avr/interrupt.h>
#include <math.h>
#include "adc.h"
#include "tmr0.h"
#include "serial_device.h"
#include <stdio.h>

#include "pwm_tmr2.h"
volatile uint8_t estat=1;
//volatile uint32_t n;
volatile int flag=0;
volatile double f0,err;
uint32_t fs,fclk;

//uint8_t n=0;

#define N 206
#define NUMFREQ 8 // seran les freqüències de 0 a 7
//#define A 1.707535257
const int8_t K[NUMFREQ]={18,20,22,24,31,34,38,42};
int32_t A[NUMFREQ];
			  
void init_A(void)
{
  uint8_t i;
  for(i=0;i<NUMFREQ;i++) A[i]=round(2*cos(2*M_PI*((float)K[i]/N))*pow(2,8));
}
/********************************************
                Clock measurement
--------------------------------------------	-
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
  setup_ADC(1,5,16);//(adc_input,v_ref,adc_pre)
  //adc_input 0-5 (default=5),8 Tª, 14 1.1V, 15 GND 
  //v_ref 0 (AREF), 1(1.1V), default=5 (5V)
  //adc_pre 2,4,8,16(default),32,64,128
  setup_tmr0(250,8);//(ocr0a, tmr0_pre)
  //tmr0_pre 1,default=8,64,256,1024
  //TMR0=prescaler*(ocr0a+1)*T_clk
  setup_pwm_tmr2(11);//(pwm_out) 3,default=11
  DDRD |=(1<<4);//pin 4 Arduino as an output. It shows sampling period (period) and ISR execution time (pulse wide)
  DDRD |=(1<<5);//pin  Arduino as an output. It shows sampling period (period) and ISR execution time (pulse wide)
  serial_init();  
  stdout = &mystdout;
  sei();
}

static int16_t Sn_1_copy[NUMFREQ]={0,0,0,0,0,0,0,0},Sn_2_copy[NUMFREQ]={0,0,0,0,0,0,0,0};

int main(void){
  init_A();
  setup();
  printf("%d\n",A[0]);
  printf("main");
  while(1){
    // ---------CALC----------
    if (flag==1){
      PORTD |= (1<<PD5);
      uint32_t XK2[NUMFREQ];
      uint8_t i;
      for (i=0;i<NUMFREQ;i++)
	{
         XK2[i]=((int32_t)Sn_1_copy[i]*Sn_1_copy[i])+((int32_t)Sn_2_copy[i]*Sn_2_copy[i])-((A[i]*Sn_1_copy[i])>>8)*Sn_2_copy[i];
	 printf("%10lu ",XK2[i]);
	}
      printf("\n");
      flag=0;
      PORTD &= ~(1<<PD5);
    }
    
  }
}

  static uint8_t n=0;
//static float Sn_1,Sn_2;

ISR(TIMER0_COMPA_vect){
  PORTD |= (1<<PD4);
  static int16_t Sn_1[NUMFREQ]={0,0,0,0,0,0,0,0}, Sn_2[NUMFREQ]={0,0,0,0,0,0,0,0};
  uint8_t i;
  int16_t Sn[NUMFREQ];
  uint8_t Xn=read8_ADC();
  start_ADC();
  for(i=0;i<NUMFREQ;i++)
    {
      Sn[i]= Xn + (int16_t)((A[i]*Sn_1[i])>>8) - Sn_2[i];
      Sn_2[i]=Sn_1[i];
      Sn_1[i]=Sn[i];
    }  
  n++; //n=0 --> N-1	N--> t=Ts*N =N/Fs
  if (n==N){
    for(i=0;i<NUMFREQ;i++)
      {
       Sn_1_copy[i]= Sn_1[i];
       Sn_2_copy[i]= Sn_2[i];
       Sn_1[i]=0;
       Sn_2[i]=0;
      }
      n=0;
     flag=1;
  }
  
 // set_pwm_tmr2(value);
  PORTD &= ~(1<<PD4);
}

