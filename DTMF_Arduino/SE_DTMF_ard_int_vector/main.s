	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	uart_putchar, @function
uart_putchar:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(10)
	breq .L3
.L4:
	lds r25,192
	sbrs r25,5
	rjmp .L4
	sts 198,r24
	ldi r24,0
	ldi r25,0
	ret
.L3:
	lds r25,192
	sbrs r25,5
	rjmp .L3
	ldi r25,lo8(13)
	sts 198,r25
	rjmp .L4
	.size	uart_putchar, .-uart_putchar
.global	init_A_FS
	.type	init_A_FS, @function
init_A_FS:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r26,lo8(K)
	ldi r27,hi8(K)
	ldi r24,lo8(17)
	st X,r24
	ldi r30,lo8(A)
	ldi r31,hi8(A)
	ldi r20,lo8(-73)
	ldi r21,lo8(1)
	ldi r22,0
	ldi r23,0
	st Z,r20
	std Z+1,r21
	std Z+2,r22
	std Z+3,r23
	ldi r24,lo8(19)
	adiw r26,1
	st X,r24
	sbiw r26,1
	ldi r20,lo8(-91)
	ldi r21,lo8(1)
	ldi r22,0
	ldi r23,0
	std Z+4,r20
	std Z+5,r21
	std Z+6,r22
	std Z+7,r23
	ldi r24,lo8(21)
	adiw r26,2
	st X,r24
	sbiw r26,2
	ldi r20,lo8(-111)
	ldi r21,lo8(1)
	ldi r22,0
	ldi r23,0
	std Z+8,r20
	std Z+9,r21
	std Z+10,r22
	std Z+11,r23
	ldi r24,lo8(23)
	adiw r26,3
	st X,r24
	sbiw r26,3
	ldi r20,lo8(124)
	ldi r21,lo8(1)
	ldi r22,0
	ldi r23,0
	std Z+12,r20
	std Z+13,r21
	std Z+14,r22
	std Z+15,r23
	ldi r24,lo8(30)
	adiw r26,4
	st X,r24
	sbiw r26,4
	ldi r20,lo8(39)
	ldi r21,lo8(1)
	ldi r22,0
	ldi r23,0
	std Z+16,r20
	std Z+17,r21
	std Z+18,r22
	std Z+19,r23
	ldi r24,lo8(33)
	adiw r26,5
	st X,r24
	sbiw r26,5
	ldi r20,lo8(-2)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	std Z+20,r20
	std Z+21,r21
	std Z+22,r22
	std Z+23,r23
	ldi r24,lo8(36)
	adiw r26,6
	st X,r24
	sbiw r26,6
	ldi r20,lo8(-46)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	std Z+24,r20
	std Z+25,r21
	std Z+26,r22
	std Z+27,r23
	ldi r24,lo8(40)
	adiw r26,7
	st X,r24
	ldi r24,lo8(-107)
	ldi r25,0
	ldi r26,0
	ldi r27,0
	std Z+28,r24
	std Z+29,r25
	std Z+30,r26
	std Z+31,r27
	ret
	.size	init_A_FS, .-init_A_FS
.global	setup
	.type	setup, @function
setup:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(16)
	ldi r22,lo8(5)
	ldi r24,lo8(1)
	call setup_ADC
	ldi r22,lo8(8)
	ldi r23,0
	ldi r24,lo8(-6)
	call setup_tmr0
	ldi r24,lo8(11)
	call setup_pwm_tmr2
	sbi 0xa,4
	sbi 0xa,5
	call serial_init
	ldi r24,lo8(mystdout)
	ldi r25,hi8(mystdout)
	sts __iob+2+1,r25
	sts __iob+2,r24
/* #APP */
 ;  64 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ret
	.size	setup, .-setup
.global	calc_boto
	.type	calc_boto, @function
calc_boto:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,0
	lds r20,XK2
	lds r21,XK2+1
	lds r22,XK2+2
	lds r23,XK2+3
	cpi r20,89
	sbci r21,-2
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	brsh .+2
	rjmp .L28
	ldi r24,lo8(1)
	ldi r25,0
.L13:
	lds r20,XK2+4
	lds r21,XK2+4+1
	lds r22,XK2+4+2
	lds r23,XK2+4+3
	cpi r20,80
	sbci r21,25
	sbci r22,1
	cpc r23,__zero_reg__
	brlo .L15
	subi r24,lo8(-(1))
	ldi r25,lo8(1)
	cpi r24,lo8(2)
	brlt .+2
	rjmp .L14
.L15:
	lds r20,XK2+8
	lds r21,XK2+8+1
	lds r22,XK2+8+2
	lds r23,XK2+8+3
	cpi r20,-112
	sbci r21,11
	sbci r22,1
	cpc r23,__zero_reg__
	brlo .L16
	subi r24,lo8(-(1))
	ldi r25,lo8(2)
	cpi r24,lo8(2)
	brlt .+2
	rjmp .L14
.L16:
	lds r20,XK2+12
	lds r21,XK2+12+1
	lds r22,XK2+12+2
	lds r23,XK2+12+3
	cpi r20,-48
	sbci r21,-18
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	brlo .L17
	subi r24,lo8(-(1))
	ldi r25,lo8(3)
	cpi r24,lo8(2)
	brlt .+2
	rjmp .L14
.L17:
	ldi r24,0
	lds r20,XK2+16
	lds r21,XK2+16+1
	lds r22,XK2+16+2
	lds r23,XK2+16+3
	cpi r20,117
	sbci r21,-15
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	brlo .+2
	rjmp .L43
	ldi r18,lo8(-1)
.L19:
	lds r20,XK2+20
	lds r21,XK2+20+1
	lds r22,XK2+20+2
	lds r23,XK2+20+3
	cpi r20,-65
	sbci r21,-69
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	brlo .L21
	subi r24,lo8(-(1))
	cpi r24,lo8(2)
	brge .L35
	ldi r18,lo8(1)
.L21:
	lds r20,XK2+24
	lds r21,XK2+24+1
	lds r22,XK2+24+2
	lds r23,XK2+24+3
	cpi r20,-74
	sbci r21,16
	sbci r22,1
	cpc r23,__zero_reg__
	brlo .L22
	subi r24,lo8(-(1))
	cpi r24,lo8(2)
	brlt .+2
	rjmp .L36
	ldi r18,lo8(2)
.L22:
	lds r20,XK2+28
	lds r21,XK2+28+1
	lds r22,XK2+28+2
	lds r23,XK2+28+3
	cpi r20,-60
	sbci r21,-69
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	brlo .L23
	subi r24,lo8(-(1))
	cpi r24,lo8(2)
	brge .L44
	sts count,r24
	ldi r24,lo8(4)
	sts i,r24
	cpi r25,lo8(-1)
	breq .L38
	ldi r18,lo8(3)
.L27:
	ldi r24,lo8(4)
	muls r25,r24
	movw r30,r0
	clr __zero_reg__
	add r30,r18
	adc r31,__zero_reg__
	sbrc r18,7
	dec r31
	subi r30,lo8(-(dial_pad))
	sbci r31,hi8(-(dial_pad))
	ld r24,Z
	ret
.L28:
	ldi r25,lo8(-1)
	rjmp .L13
.L43:
	ldi r24,lo8(1)
	ldi r18,0
	rjmp .L19
.L35:
	ldi r25,lo8(1)
.L14:
	sts count,r24
	sts i,r25
.L38:
	ldi r24,lo8(69)
	ret
.L23:
	sts count,r24
	ldi r24,lo8(4)
	sts i,r24
	cpi r25,lo8(-1)
	breq .L45
	cpi r18,lo8(-1)
	breq .L38
	rjmp .L27
.L45:
	cpi r18,lo8(-1)
	brne .L38
	ldi r24,lo8(83)
	ret
.L44:
	ldi r25,lo8(3)
	rjmp .L14
.L36:
	ldi r25,lo8(2)
	rjmp .L14
	.size	calc_boto, .-calc_boto
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"main"
.LC1:
	.string	"%d"
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call init_A_FS
	call setup
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call puts
	ldi r17,lo8(1)
	ldi r28,lo8(.LC1)
	ldi r29,hi8(.LC1)
.L47:
	lds r24,flag
	lds r25,flag+1
	sbiw r24,1
	brne .L47
	sbi 0xb,5
	lds r10,Sn_1_copy
	lds r11,Sn_1_copy+1
	lds r30,Sn_2_copy
	lds r31,Sn_2_copy+1
	movw r18,r10
	movw r26,r10
	call __mulhisi3
	movw r12,r22
	movw r14,r24
	movw r18,r30
	movw r26,r30
	call __mulhisi3
	add r12,r22
	adc r13,r23
	adc r14,r24
	adc r15,r25
	lds r18,A
	lds r19,A+1
	lds r20,A+2
	lds r21,A+3
	movw r26,r10
	call __mulshisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	sub r12,r22
	sbc r13,r23
	sbc r14,r24
	sbc r15,r25
	sts XK2,r12
	sts XK2+1,r13
	sts XK2+2,r14
	sts XK2+3,r15
	lds r10,Sn_1_copy+2
	lds r11,Sn_1_copy+2+1
	lds r30,Sn_2_copy+2
	lds r31,Sn_2_copy+2+1
	movw r18,r10
	movw r26,r10
	call __mulhisi3
	movw r12,r22
	movw r14,r24
	movw r18,r30
	movw r26,r30
	call __mulhisi3
	add r12,r22
	adc r13,r23
	adc r14,r24
	adc r15,r25
	lds r18,A+4
	lds r19,A+4+1
	lds r20,A+4+2
	lds r21,A+4+3
	movw r26,r10
	call __mulshisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	sub r12,r22
	sbc r13,r23
	sbc r14,r24
	sbc r15,r25
	sts XK2+4,r12
	sts XK2+4+1,r13
	sts XK2+4+2,r14
	sts XK2+4+3,r15
	lds r10,Sn_1_copy+4
	lds r11,Sn_1_copy+4+1
	lds r30,Sn_2_copy+4
	lds r31,Sn_2_copy+4+1
	movw r18,r10
	movw r26,r10
	call __mulhisi3
	movw r12,r22
	movw r14,r24
	movw r18,r30
	movw r26,r30
	call __mulhisi3
	add r12,r22
	adc r13,r23
	adc r14,r24
	adc r15,r25
	lds r18,A+8
	lds r19,A+8+1
	lds r20,A+8+2
	lds r21,A+8+3
	movw r26,r10
	call __mulshisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	sub r12,r22
	sbc r13,r23
	sbc r14,r24
	sbc r15,r25
	sts XK2+8,r12
	sts XK2+8+1,r13
	sts XK2+8+2,r14
	sts XK2+8+3,r15
	lds r10,Sn_1_copy+6
	lds r11,Sn_1_copy+6+1
	lds r30,Sn_2_copy+6
	lds r31,Sn_2_copy+6+1
	movw r18,r10
	movw r26,r10
	call __mulhisi3
	movw r12,r22
	movw r14,r24
	movw r18,r30
	movw r26,r30
	call __mulhisi3
	add r12,r22
	adc r13,r23
	adc r14,r24
	adc r15,r25
	lds r18,A+12
	lds r19,A+12+1
	lds r20,A+12+2
	lds r21,A+12+3
	movw r26,r10
	call __mulshisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	sub r12,r22
	sbc r13,r23
	sbc r14,r24
	sbc r15,r25
	sts XK2+12,r12
	sts XK2+12+1,r13
	sts XK2+12+2,r14
	sts XK2+12+3,r15
	lds r10,Sn_1_copy+8
	lds r11,Sn_1_copy+8+1
	lds r30,Sn_2_copy+8
	lds r31,Sn_2_copy+8+1
	movw r18,r10
	movw r26,r10
	call __mulhisi3
	movw r12,r22
	movw r14,r24
	movw r18,r30
	movw r26,r30
	call __mulhisi3
	add r12,r22
	adc r13,r23
	adc r14,r24
	adc r15,r25
	lds r18,A+16
	lds r19,A+16+1
	lds r20,A+16+2
	lds r21,A+16+3
	movw r26,r10
	call __mulshisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	sub r12,r22
	sbc r13,r23
	sbc r14,r24
	sbc r15,r25
	sts XK2+16,r12
	sts XK2+16+1,r13
	sts XK2+16+2,r14
	sts XK2+16+3,r15
	lds r10,Sn_1_copy+10
	lds r11,Sn_1_copy+10+1
	lds r30,Sn_2_copy+10
	lds r31,Sn_2_copy+10+1
	movw r18,r10
	movw r26,r10
	call __mulhisi3
	movw r12,r22
	movw r14,r24
	movw r18,r30
	movw r26,r30
	call __mulhisi3
	add r12,r22
	adc r13,r23
	adc r14,r24
	adc r15,r25
	lds r18,A+20
	lds r19,A+20+1
	lds r20,A+20+2
	lds r21,A+20+3
	movw r26,r10
	call __mulshisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	sub r12,r22
	sbc r13,r23
	sbc r14,r24
	sbc r15,r25
	sts XK2+20,r12
	sts XK2+20+1,r13
	sts XK2+20+2,r14
	sts XK2+20+3,r15
	lds r10,Sn_1_copy+12
	lds r11,Sn_1_copy+12+1
	lds r30,Sn_2_copy+12
	lds r31,Sn_2_copy+12+1
	movw r18,r10
	movw r26,r10
	call __mulhisi3
	movw r12,r22
	movw r14,r24
	movw r18,r30
	movw r26,r30
	call __mulhisi3
	add r12,r22
	adc r13,r23
	adc r14,r24
	adc r15,r25
	lds r18,A+24
	lds r19,A+24+1
	lds r20,A+24+2
	lds r21,A+24+3
	movw r26,r10
	call __mulshisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	sub r12,r22
	sbc r13,r23
	sbc r14,r24
	sbc r15,r25
	sts XK2+24,r12
	sts XK2+24+1,r13
	sts XK2+24+2,r14
	sts XK2+24+3,r15
	lds r10,Sn_1_copy+14
	lds r11,Sn_1_copy+14+1
	lds r30,Sn_2_copy+14
	lds r31,Sn_2_copy+14+1
	movw r18,r10
	movw r26,r10
	call __mulhisi3
	movw r12,r22
	movw r14,r24
	movw r18,r30
	movw r26,r30
	call __mulhisi3
	add r12,r22
	adc r13,r23
	adc r14,r24
	adc r15,r25
	lds r18,A+28
	lds r19,A+28+1
	lds r20,A+28+2
	lds r21,A+28+3
	movw r26,r10
	call __mulshisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	sub r12,r22
	sbc r13,r23
	sbc r14,r24
	sbc r15,r25
	sts XK2+28,r12
	sts XK2+28+1,r13
	sts XK2+28+2,r14
	sts XK2+28+3,r15
	call calc_boto
	lds r25,estat.1717
	tst r25
	breq .L49
	cpi r25,lo8(1)
	brne .L62
	cpi r24,lo8(83)
	breq .L63
.L51:
	sts flag+1,__zero_reg__
	sts flag,__zero_reg__
	cbi 0xb,5
	rjmp .L47
.L49:
	cpi r24,lo8(83)
	breq .L51
	cpi r24,lo8(69)
	breq .L51
	mov __tmp_reg__,r24
	lsl r0
	sbc r25,r25
	call putchar
	sts estat.1717,r17
	rjmp .L51
.L62:
	push __zero_reg__
	push r25
	push r29
	push r28
	call printf
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	rjmp .L51
.L63:
	sts estat.1717,__zero_reg__
	rjmp .L51
	.size	main, .-main
	.text
.global	capa_3
	.type	capa_3, @function
capa_3:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r25,estat.1717
	tst r25
	breq .L66
	cpi r25,lo8(1)
	brne .L77
	cpi r24,lo8(83)
	breq .L78
.L64:
	ret
.L77:
	push __zero_reg__
	push r25
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	push r25
	push r24
	call printf
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	ret
.L66:
	cpi r24,lo8(83)
	breq .L64
	cpi r24,lo8(69)
	breq .L64
	mov __tmp_reg__,r24
	lsl r0
	sbc r25,r25
	call putchar
	ldi r24,lo8(1)
	sts estat.1717,r24
	ret
.L78:
	sts estat.1717,__zero_reg__
	ret
	.size	capa_3, .-capa_3
.global	__vector_14
	.type	__vector_14, @function
__vector_14:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,15
	out __SP_H__,r29
	out __SP_L__,r28
/* prologue: Signal */
/* frame size = 15 */
/* stack size = 48 */
.L__stack_usage = 48
	sbi 0xb,4
	call read8_ADC
	std Y+13,r24
	call start_ADC
	ldd r24,Y+13
	mov r30,r24
	ldi r31,0
	lds r8,Sn_1.1728
	lds r9,Sn_1.1728+1
	lds r18,A
	lds r19,A+1
	lds r20,A+2
	lds r21,A+3
	movw r26,r8
	call __mulshisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	movw r22,r30
	add r22,r24
	adc r23,r25
	lds r24,Sn_2.1729
	lds r25,Sn_2.1729+1
	movw r18,r22
	sub r18,r24
	sbc r19,r25
	std Y+2,r19
	std Y+1,r18
	sts Sn_2.1729+1,r9
	sts Sn_2.1729,r8
	sts Sn_1.1728+1,r19
	sts Sn_1.1728,r18
	lds r10,Sn_1.1728+2
	lds r11,Sn_1.1728+2+1
	lds r18,A+4
	lds r19,A+4+1
	lds r20,A+4+2
	lds r21,A+4+3
	movw r26,r10
	call __mulshisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	movw r22,r30
	add r22,r24
	adc r23,r25
	lds r24,Sn_2.1729+2
	lds r25,Sn_2.1729+2+1
	movw r18,r22
	sub r18,r24
	sbc r19,r25
	std Y+4,r19
	std Y+3,r18
	sts Sn_2.1729+2+1,r11
	sts Sn_2.1729+2,r10
	sts Sn_1.1728+2+1,r19
	sts Sn_1.1728+2,r18
	lds r12,Sn_1.1728+4
	lds r13,Sn_1.1728+4+1
	lds r18,A+8
	lds r19,A+8+1
	lds r20,A+8+2
	lds r21,A+8+3
	movw r26,r12
	call __mulshisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	movw r22,r30
	add r22,r24
	adc r23,r25
	lds r24,Sn_2.1729+4
	lds r25,Sn_2.1729+4+1
	movw r18,r22
	sub r18,r24
	sbc r19,r25
	std Y+6,r19
	std Y+5,r18
	sts Sn_2.1729+4+1,r13
	sts Sn_2.1729+4,r12
	sts Sn_1.1728+4+1,r19
	sts Sn_1.1728+4,r18
	lds r14,Sn_1.1728+6
	lds r15,Sn_1.1728+6+1
	lds r18,A+12
	lds r19,A+12+1
	lds r20,A+12+2
	lds r21,A+12+3
	movw r26,r14
	call __mulshisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	movw r22,r30
	add r22,r24
	adc r23,r25
	lds r24,Sn_2.1729+6
	lds r25,Sn_2.1729+6+1
	movw r18,r22
	sub r18,r24
	sbc r19,r25
	std Y+8,r19
	std Y+7,r18
	sts Sn_2.1729+6+1,r15
	sts Sn_2.1729+6,r14
	sts Sn_1.1728+6+1,r19
	sts Sn_1.1728+6,r18
	lds r16,Sn_1.1728+8
	lds r17,Sn_1.1728+8+1
	lds r18,A+16
	lds r19,A+16+1
	lds r20,A+16+2
	lds r21,A+16+3
	movw r26,r16
	call __mulshisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	movw r22,r30
	add r22,r24
	adc r23,r25
	lds r24,Sn_2.1729+8
	lds r25,Sn_2.1729+8+1
	movw r18,r22
	sub r18,r24
	sbc r19,r25
	std Y+10,r19
	std Y+9,r18
	sts Sn_2.1729+8+1,r17
	sts Sn_2.1729+8,r16
	sts Sn_1.1728+8+1,r19
	sts Sn_1.1728+8,r18
	lds r6,Sn_1.1728+10
	lds r7,Sn_1.1728+10+1
	lds r18,A+20
	lds r19,A+20+1
	lds r20,A+20+2
	lds r21,A+20+3
	movw r26,r6
	call __mulshisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	movw r22,r30
	add r22,r24
	adc r23,r25
	lds r24,Sn_2.1729+10
	lds r25,Sn_2.1729+10+1
	movw r18,r22
	sub r18,r24
	sbc r19,r25
	std Y+12,r19
	std Y+11,r18
	sts Sn_2.1729+10+1,r7
	sts Sn_2.1729+10,r6
	sts Sn_1.1728+10+1,r19
	sts Sn_1.1728+10,r18
	lds r4,Sn_1.1728+12
	lds r5,Sn_1.1728+12+1
	lds r18,A+24
	lds r19,A+24+1
	lds r20,A+24+2
	lds r21,A+24+3
	movw r26,r4
	call __mulshisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	movw r22,r30
	add r22,r24
	adc r23,r25
	lds r24,Sn_2.1729+12
	lds r25,Sn_2.1729+12+1
	movw r2,r22
	sub r2,r24
	sbc r3,r25
	sts Sn_2.1729+12+1,r5
	sts Sn_2.1729+12,r4
	sts Sn_1.1728+12+1,r3
	sts Sn_1.1728+12,r2
	lds r24,Sn_1.1728+14
	lds r25,Sn_1.1728+14+1
	std Y+15,r25
	std Y+14,r24
	lds r18,A+28
	lds r19,A+28+1
	lds r20,A+28+2
	lds r21,A+28+3
	movw r26,r24
	call __mulshisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	add r30,r24
	adc r31,r25
	lds r24,Sn_2.1729+14
	lds r25,Sn_2.1729+14+1
	sub r30,r24
	sbc r31,r25
	ldd r18,Y+14
	ldd r19,Y+15
	sts Sn_2.1729+14+1,r19
	sts Sn_2.1729+14,r18
	sts Sn_1.1728+14+1,r31
	sts Sn_1.1728+14,r30
	lds r24,n
	subi r24,lo8(-(1))
	sts n,r24
	cpi r24,lo8(-59)
	breq .+2
	rjmp .L80
	ldd r24,Y+1
	ldd r25,Y+2
	sts Sn_1_copy+1,r25
	sts Sn_1_copy,r24
	sts Sn_1.1728+1,__zero_reg__
	sts Sn_1.1728,__zero_reg__
	ldd r18,Y+3
	ldd r19,Y+4
	sts Sn_1_copy+2+1,r19
	sts Sn_1_copy+2,r18
	sts Sn_1.1728+2+1,__zero_reg__
	sts Sn_1.1728+2,__zero_reg__
	ldd r24,Y+5
	ldd r25,Y+6
	sts Sn_1_copy+4+1,r25
	sts Sn_1_copy+4,r24
	sts Sn_1.1728+4+1,__zero_reg__
	sts Sn_1.1728+4,__zero_reg__
	ldd r18,Y+7
	ldd r19,Y+8
	sts Sn_1_copy+6+1,r19
	sts Sn_1_copy+6,r18
	sts Sn_1.1728+6+1,__zero_reg__
	sts Sn_1.1728+6,__zero_reg__
	ldd r24,Y+9
	ldd r25,Y+10
	sts Sn_1_copy+8+1,r25
	sts Sn_1_copy+8,r24
	sts Sn_1.1728+8+1,__zero_reg__
	sts Sn_1.1728+8,__zero_reg__
	ldd r18,Y+11
	ldd r19,Y+12
	sts Sn_1_copy+10+1,r19
	sts Sn_1_copy+10,r18
	sts Sn_1.1728+10+1,__zero_reg__
	sts Sn_1.1728+10,__zero_reg__
	sts Sn_1_copy+12+1,r3
	sts Sn_1_copy+12,r2
	sts Sn_1.1728+12+1,__zero_reg__
	sts Sn_1.1728+12,__zero_reg__
	sts Sn_1_copy+14+1,r31
	sts Sn_1_copy+14,r30
	sts Sn_1.1728+14+1,__zero_reg__
	sts Sn_1.1728+14,__zero_reg__
	sts Sn_2_copy+1,r9
	sts Sn_2_copy,r8
	sts Sn_2.1729+1,__zero_reg__
	sts Sn_2.1729,__zero_reg__
	sts Sn_2_copy+2+1,r11
	sts Sn_2_copy+2,r10
	sts Sn_2.1729+2+1,__zero_reg__
	sts Sn_2.1729+2,__zero_reg__
	sts Sn_2_copy+4+1,r13
	sts Sn_2_copy+4,r12
	sts Sn_2.1729+4+1,__zero_reg__
	sts Sn_2.1729+4,__zero_reg__
	sts Sn_2_copy+6+1,r15
	sts Sn_2_copy+6,r14
	sts Sn_2.1729+6+1,__zero_reg__
	sts Sn_2.1729+6,__zero_reg__
	sts Sn_2_copy+8+1,r17
	sts Sn_2_copy+8,r16
	sts Sn_2.1729+8+1,__zero_reg__
	sts Sn_2.1729+8,__zero_reg__
	sts Sn_2_copy+10+1,r7
	sts Sn_2_copy+10,r6
	sts Sn_2.1729+10+1,__zero_reg__
	sts Sn_2.1729+10,__zero_reg__
	sts Sn_2_copy+12+1,r5
	sts Sn_2_copy+12,r4
	sts Sn_2.1729+12+1,__zero_reg__
	sts Sn_2.1729+12,__zero_reg__
	ldd r24,Y+14
	ldd r25,Y+15
	sts Sn_2_copy+14+1,r25
	sts Sn_2_copy+14,r24
	sts Sn_2.1729+14+1,__zero_reg__
	sts Sn_2.1729+14,__zero_reg__
	sts n,__zero_reg__
	ldi r24,lo8(1)
	ldi r25,0
	sts flag+1,r25
	sts flag,r24
.L80:
	cbi 0xb,4
/* epilogue start */
	adiw r28,15
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_14, .-__vector_14
	.local	Sn_2.1729
	.comm	Sn_2.1729,16,1
	.local	Sn_1.1728
	.comm	Sn_1.1728,16,1
	.local	estat.1717
	.comm	estat.1717,1,1
	.local	n
	.comm	n,1,1
	.comm	count,1,1
	.comm	i,1,1
	.comm	XK2,32,1
.global	Sn_2_copy
	.section .bss
	.type	Sn_2_copy, @object
	.size	Sn_2_copy, 16
Sn_2_copy:
	.zero	16
.global	Sn_1_copy
	.type	Sn_1_copy, @object
	.size	Sn_1_copy, 16
Sn_1_copy:
	.zero	16
	.data
	.type	mystdout, @object
	.size	mystdout, 14
mystdout:
	.zero	3
	.byte	2
	.zero	4
	.word	gs(uart_putchar)
	.word	0
	.word	0
	.comm	A,32,1
	.comm	K,8,1
.global	dial_pad
	.section	.rodata
	.type	dial_pad, @object
	.size	dial_pad, 16
dial_pad:
	.byte	49
	.byte	50
	.byte	51
	.byte	65
	.byte	52
	.byte	53
	.byte	54
	.byte	66
	.byte	55
	.byte	56
	.byte	57
	.byte	67
	.byte	42
	.byte	48
	.byte	35
	.byte	68
.global	LLINDAR
	.type	LLINDAR, @object
	.size	LLINDAR, 32
LLINDAR:
	.byte	88
	.byte	-2
	.byte	0
	.byte	0
	.byte	79
	.byte	25
	.byte	1
	.byte	0
	.byte	-113
	.byte	11
	.byte	1
	.byte	0
	.byte	-49
	.byte	-18
	.byte	0
	.byte	0
	.byte	116
	.byte	-15
	.byte	0
	.byte	0
	.byte	-66
	.byte	-69
	.byte	0
	.byte	0
	.byte	-75
	.byte	16
	.byte	1
	.byte	0
	.byte	-61
	.byte	-69
	.byte	0
	.byte	0
.global	FS
	.type	FS, @object
	.size	FS, 16
FS:
	.word	697
	.word	770
	.word	852
	.word	941
	.word	1209
	.word	1336
	.word	1477
	.word	1633
	.comm	fclk,4,1
	.comm	fs,4,1
	.comm	err,4,1
	.comm	f0,4,1
.global	flag
	.section .bss
	.type	flag, @object
	.size	flag, 2
flag:
	.zero	2
	.ident	"GCC: (GNU) 4.9.2"
.global __do_copy_data
.global __do_clear_bss
