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


#define K 19.0
#define N 218
#define A ((int32_t) round(2*cos(2*M_PI*(K/N))*pow(2,8)))

//#define A 1.707535257


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

static int16_t Sn_1_copy=0,Sn_2_copy=0;

int main(void){
  setup();
  printf("%d\n",A);
  printf("main");
  while(1){
    // ---------CALC----------
    if (flag==1){
      PORTD |= (1<<PD5);
      uint32_t XK2;
      XK2=((int32_t)Sn_1_copy*Sn_1_copy)+((int32_t)Sn_2_copy*Sn_2_copy)-((A*Sn_1_copy)>>8)*Sn_2_copy;
      //printf("%d\n",XK2);
      /*//////fm = (double)8000//////
      f0=((double)8000/(double)n);
      //printf("%f\n",f0);
      fs=8000+f0; // Sumem f0 a fm ja que hem comprobat que si disminuiem fm ens augmentava f0. Per tant f0 en valor 0 esta per sobre els 20k.
      printf("fs= %ld\n",fs);
      fclk=fs*800;
      //////frequencia del clock de l'arduino//////
      printf("fclk= %ld\n",fclk);
      err=(f0/20000)*100;
      printf("error= %f\n",err);*/
      flag=0;
      PORTD &= ~(1<<PD5);
      printf("%u\n",XK2);
    }
    
  }
}

  static uint8_t n=0;
//static float Sn_1,Sn_2;

ISR(TIMER0_COMPA_vect){
  PORTD |= (1<<PD4);
  static int16_t Sn_1=0,Sn_2=0;
  uint8_t Xn=read8_ADC();
  int16_t Sn;

  start_ADC();
  n++; //n=0 --> N-1	N--> t=Ts*N =N/Fs
  Sn=Xn + ((int16_t)(A*Sn_1)>>8) - Sn_2;
  Sn_2=Sn_1;
  Sn_1=Sn;
  if (n==N-1){
    Sn_1_copy=Sn_1;
    Sn_2_copy=Sn_2;
    n=0;
    Sn_1=0;
    Sn_2=0;
    flag=1;
    //printf("%f\n",Sn);
    //printf("%d\n",Xn);
  }
  
 // set_pwm_tmr2(value);
  PORTD &= ~(1<<PD4);
}

