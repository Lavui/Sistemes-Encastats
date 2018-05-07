	.file	"adc.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	setup_ADC
	.type	setup_ADC, @function
setup_ADC:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(16)
	brsh .L13
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(CSWTCH.2))
	sbci r31,hi8(-(CSWTCH.2))
	ld r18,Z
	movw r30,r24
	subi r30,lo8(-(CSWTCH.1))
	sbci r31,hi8(-(CSWTCH.1))
	ld r24,Z
	ori r24,lo8(32)
	cpi r22,lo8(6)
	brsh .L14
.L20:
	mov r30,r22
	ldi r31,0
	subi r30,lo8(-(CSWTCH.3))
	sbci r31,hi8(-(CSWTCH.3))
	ld r19,Z
	cpi r20,lo8(16)
	breq .L4
.L21:
	cpi r20,lo8(17)
	brlo .L19
	cpi r20,lo8(64)
	breq .L10
	cpi r20,lo8(-128)
	breq .L11
	cpi r20,lo8(32)
	brne .L4
	ldi r25,lo8(-123)
	or r24,r19
	sts 124,r24
	sts 122,r25
	sts 126,r18
	ret
.L13:
	ldi r24,lo8(37)
	ldi r18,lo8(31)
	cpi r22,lo8(6)
	brlo .L20
.L14:
	ldi r19,lo8(64)
	cpi r20,lo8(16)
	brne .L21
.L4:
	ldi r25,lo8(-124)
	or r24,r19
	sts 124,r24
	sts 122,r25
	sts 126,r18
	ret
.L19:
	cpi r20,lo8(4)
	breq .L7
	cpi r20,lo8(8)
	breq .L8
	cpi r20,lo8(2)
	brne .L4
	ldi r25,lo8(-127)
	or r24,r19
	sts 124,r24
	sts 122,r25
	sts 126,r18
	ret
.L11:
	ldi r25,lo8(-121)
	or r24,r19
	sts 124,r24
	sts 122,r25
	sts 126,r18
	ret
.L8:
	ldi r25,lo8(-125)
	or r24,r19
	sts 124,r24
	sts 122,r25
	sts 126,r18
	ret
.L10:
	ldi r25,lo8(-122)
	or r24,r19
	sts 124,r24
	sts 122,r25
	sts 126,r18
	ret
.L7:
	ldi r25,lo8(-126)
	or r24,r19
	sts 124,r24
	sts 122,r25
	sts 126,r18
	ret
	.size	setup_ADC, .-setup_ADC
.global	read8_ADC
	.type	read8_ADC, @function
read8_ADC:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L23:
	lds r24,122
	sbrc r24,6
	rjmp .L23
	lds r24,121
	ret
	.size	read8_ADC, .-read8_ADC
.global	start_ADC
	.type	start_ADC, @function
start_ADC:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(122)
	ldi r31,0
	ld r24,Z
	ori r24,lo8(64)
	st Z,r24
	ret
	.size	start_ADC, .-start_ADC
	.section	.rodata
	.type	CSWTCH.3, @object
	.size	CSWTCH.3, 6
CSWTCH.3:
	.byte	0
	.byte	-64
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.type	CSWTCH.2, @object
	.size	CSWTCH.2, 16
CSWTCH.2:
	.byte	62
	.byte	61
	.byte	59
	.byte	55
	.byte	47
	.byte	31
	.byte	31
	.byte	31
	.byte	63
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	63
	.byte	63
	.type	CSWTCH.1, @object
	.size	CSWTCH.1, 16
CSWTCH.1:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	8
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	14
	.byte	15
	.ident	"GCC: (GNU) 4.9.2"
.global __do_copy_data
