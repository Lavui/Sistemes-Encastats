#include <inttypes.h>
#include <avr/io.h>
#include "serial_device.h"

#define NUM (F_CPU/16)

#define BAUDRATE_L(x) UINT8_C((NUM/x-1)      & 0xff)
#define BAUDRATE_H(x) UINT8_C((NUM/x-1) >> 8 & 0xf)

/*
 * Initialize the UART0
 */
void serial_init(void) {
  // set baud rate to 9600 bps. Ignore lower rates.
  UBRR0H = BAUDRATE_H(9600);
  UBRR0L = BAUDRATE_L(9600);
  // set normal baud rate 
  UCSR0A = UINT8_C(0);
  UCSR0C = 
    (_BV(UCSZ01)   | _BV(UCSZ00)) &   // 8 bit frame
    ~_BV(UMSEL01) & ~_BV(UMSEL00) &   // asincronous mode
    ~_BV(UPM01)   & ~_BV(UPM00)   &   // no parity
    ~_BV(USBS0)   ;                   // 1 stop bit
  // Enable transmision and reception
  UCSR0B = _BV(RXEN0) | _BV(TXEN0);
}


uint8_t serial_get(void) {
  // polling on RXC until data received
  loop_until_bit_is_set(UCSR0A, RXC0);  	
  return UDR0;
}


bool serial_can_read(void) {
  // test whether there is something to read
  return bit_is_set(UCSR0A, RXC0);
}


void serial_put(uint8_t c) {
  // wait last transmision finishes
  loop_until_bit_is_set(UCSR0A, UDRE0);
  // send new byte
  UDR0 = c;
}

