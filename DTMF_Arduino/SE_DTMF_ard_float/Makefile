PORT = /dev/ttyUSB0
PICOCOM =picocom $(PORT)



.PHONY : loadmain
loadmain: main.hex
	avrdude -c arduino -p atmega328p -P $(PORT) -U main.hex
	rm -f *~ *.hex main
	$(PICOCOM)

main: adc.c pwm_tmr2.c  tmr0.c adc.h pwm_tmr2.h tmr0.h serial_device.c main.c
	avr-gcc -std=c99 -Os -mmcu=atmega328p -fshort-enums -Wl,-u,vfprintf -lprintf_flt -lm -DF_CPU=16000000UL main.c adc.c pwm_tmr2.c tmr0.c serial_device.c -o main

main.hex: main
	avr-objcopy -Oihex main main.hex


