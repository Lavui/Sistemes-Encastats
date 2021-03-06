#include <avr/interrupt.h>
#include <math.h>
#include "adc.h"
#include "tmr0.h"
#include "serial_device.h"
#include <stdio.h>

#include "pwm_tmr2.h"

//volatile uint32_t n;
volatile int flag=0;
volatile double f0,err;
uint32_t fs,fclk;

//uint8_t n=0;
//const char calc_boto(void);
//void capa_3(char capa_2);

#define N 197 // la N
#define FM 8000 // freqüència de mostratge
#define NUMFREQ 8 // seran les freqüències de 0 a 7
//#define A 1.707535257

const uint16_t FS[NUMFREQ]={697,770,852,941,1209,1336,1477,1633};
const uint32_t LLINDAR[NUMFREQ]={44694,41703,48811,30602,40294,38436,9945,11383};
const char dial_pad[4][4]={{'1','2','3','A'},{'4','5','6','B'},{'7','8','9','C'},{'*','0','#','D'}};

uint8_t K[NUMFREQ];
int32_t A[NUMFREQ];
			  
void init_A_FS(void)
{
  for(uint8_t i=0;i<NUMFREQ;i++){
    K[i]=round((float)FS[i]*N/FM);
    A[i]=round(2*cos(2*M_PI*((float)K[i]/N))*pow(2,8));  
  }
}

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
  setup_ADC(1,5,16); //(adc_input,v_ref,adc_pre)
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

int16_t Sn_1_copy[NUMFREQ]={0,0,0,0,0,0,0,0},Sn_2_copy[NUMFREQ]={0,0,0,0,0,0,0,0};
uint32_t XK2[NUMFREQ];

int main(void){
  uint8_t i;
  char rebut;
  init_A_FS();
  setup();
  printf("main\n");
  while(1){
    // ---------CALC----------
    if (flag==1){ // s'han rebut N mostres
      PORTD |= (1<<PD5);
      for (i=0;i<NUMFREQ;i++) // calculem XK2 per a cada frequencia
	{
         XK2[i]=((int32_t)Sn_1_copy[i]*Sn_1_copy[i])+((int32_t)Sn_2_copy[i]*Sn_2_copy[i])-((A[i]*Sn_1_copy[i])>>8)*Sn_2_copy[i];
	 printf("%10lu ",XK2[i]);
	}
      printf("\n");
      //rebut=calc_boto(); // determinem el que es rep: caracter, espai(S) o error(E) 
      //capa_3(rebut); // la capa3 es maquina d'estats que determina el caracter rebut, L'envia via serie.
      flag=0;
      PORTD &= ~(1<<PD5);
    }
    
  }
}

int8_t i,count;//les posem globals ja que si no, passen coses rares (capa_3 no va bé si no es fa algun printf a algun lloc del
//codi!
/*const char calc_boto(void){
  int8_t low=-1, high=-1;
  for (count=0, i=0; i<4; i++){ //mirem freq. baixes
    if (LLINDAR[i]<XK2[i]){
       count++;
       if (count>1) return 'E'; //mes de 2 freq. detectades: error
       low=i;
    }
  } 
  for (count=0, i=0; i<4; i++){ //mirem freq. altes
    if (LLINDAR[i+4]<XK2[i+4]){
       count++;
       if (count>1) return 'E'; //mes de 2 freq. detectades: error
       high=i;
    }
  }
  if((low==-1)&&(high==-1)) return 'S'; //cap freq. detectada: space
  if((low==-1)||(high==-1)) return 'E'; //detectada 1 freq. sola: error
  //printf("%c",dial_pad[low][high]);
  return dial_pad[low][high]; // low i high tenen les posicions freq. detectades: key
}

void capa_3(char capa_2){
  static uint8_t estat=0;
  switch (estat){
    case 0:
           if (!((capa_2=='S') || (capa_2=='E'))) {
                    printf("%c", capa_2); estat=1;
	            return;
                    }
      //else{printf("-");}
      break;
    case 1:
      if (capa_2=='S') {
                        estat=0;
	                return;
                       }
      //else printf("%d",estat);
      break;
     default:
       printf("%d",estat);
  }
  }*/

/*
void calc_boto(void){
  //Sortida d'aquesta capa 2: 'char' 'silenci' '?'
  uint32_t sumL3=0, maxL4=0, mitL3, llinL, sumH3=0, maxH4=0, mitH3, llinH;
  for (int i=0; i<4 ; i++){
    sumL3 += XK2[i];
    sumH3 += XK2[i+4];
    if (maxL4<XK2[i]) maxL4=XK2[i];
    if (maxH4<XK2[i+4]) maxH4=XK2[i+4];
  }
  sumL3-=maxL4; // sumL3 té la suma dels 3 valors menors; maxL4 té el valor màxim dels L
  sumH3-=maxH4; 
  mitL3=sumL3/3;
  mitH3=sumH3/3;
  llinL = mitL3+(0.9*(maxL4-mitL3));
  llinH = mitH3+(0.8*(maxH4-mitH3));
  if (maxL4>llinL) printf("%8lu %8lu %8.0f%%",llinL, maxL4, round(100.0*maxL4/llinL));
  if (maxH4>llinH) printf("%8lu %8lu %8.0f%%",llinH, maxH4, round(100.0*maxH4/llinH));
}
*/


static uint8_t n=0;

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
