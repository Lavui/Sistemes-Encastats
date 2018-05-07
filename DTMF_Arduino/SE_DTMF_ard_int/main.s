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
 ;  67 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ret
	.size	setup, .-setup
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
.LC1:
	.string	"main"
.LC2:
	.string	"%lu\n"
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call setup
	push __zero_reg__
	push __zero_reg__
	ldi r24,lo8(1)
	push r24
	ldi r24,lo8(-75)
	push r24
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	push r25
	push r24
	call printf
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	push r25
	push r24
	call printf
	in r18,__SP_L__
	in r19,__SP_H__
	subi r18,-8
	sbci r19,-1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r19
	out __SREG__,__tmp_reg__
	out __SP_L__,r18
	ldi r28,lo8(.LC2)
	ldi r29,hi8(.LC2)
.L12:
	lds r24,flag
	lds r25,flag+1
	sbiw r24,1
	brne .L12
	sbi 0xb,5
	lds r20,Sn_1_copy
	lds r21,Sn_1_copy+1
	lds r30,Sn_2_copy
	lds r31,Sn_2_copy+1
	sts flag+1,__zero_reg__
	sts flag,__zero_reg__
	cbi 0xb,5
	movw r18,r20
	movw r26,r20
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
	ldi r18,lo8(-75)
	ldi r19,lo8(1)
	movw r26,r20
	call __usmulhisi3
	mov r18,r23
	mov r19,r24
	mov r20,r25
	clr r21
	sbrc r20,7
	dec r21
	movw r26,r30
	call __mulshisi3
	movw r20,r14
	movw r18,r12
	sub r18,r22
	sbc r19,r23
	sbc r20,r24
	sbc r21,r25
	movw r26,r20
	movw r24,r18
	push r27
	push r26
	push r25
	push r18
	push r29
	push r28
	call printf
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	rjmp .L12
	.size	main, .-main
	.text
.global	__vector_14
	.type	__vector_14, @function
__vector_14:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
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
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: Signal */
/* frame size = 1 */
/* stack size = 19 */
.L__stack_usage = 19
	sbi 0xb,4
	call read8_ADC
	std Y+1,r24
	call start_ADC
	lds r17,n
	subi r17,lo8(-(1))
	sts n,r17
	lds r20,Sn_1.1687
	lds r21,Sn_1.1687+1
	ldd r24,Y+1
	mov r30,r24
	ldi r31,0
	ldi r18,lo8(-75)
	ldi r19,lo8(1)
	movw r26,r20
	call __usmulhisi3
	clr r27
	sbrc r25,7
	dec r27
	mov r26,r25
	mov r25,r24
	mov r24,r23
	movw r22,r30
	add r22,r24
	adc r23,r25
	lds r24,Sn_2.1688
	lds r25,Sn_2.1688+1
	sub r22,r24
	sbc r23,r25
	sts Sn_2.1688+1,r21
	sts Sn_2.1688,r20
	sts Sn_1.1687+1,r23
	sts Sn_1.1687,r22
	cpi r17,lo8(-39)
	brne .L16
	sts Sn_1_copy+1,r23
	sts Sn_1_copy,r22
	sts Sn_2_copy+1,r21
	sts Sn_2_copy,r20
	sts n,__zero_reg__
	sts Sn_1.1687+1,__zero_reg__
	sts Sn_1.1687,__zero_reg__
	sts Sn_2.1688+1,__zero_reg__
	sts Sn_2.1688,__zero_reg__
	ldi r24,lo8(1)
	ldi r25,0
	sts flag+1,r25
	sts flag,r24
.L16:
	cbi 0xb,4
/* epilogue start */
	pop __tmp_reg__
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
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_14, .-__vector_14
	.local	Sn_2.1688
	.comm	Sn_2.1688,2,1
	.local	Sn_1.1687
	.comm	Sn_1.1687,2,1
	.local	n
	.comm	n,1,1
	.local	Sn_2_copy
	.comm	Sn_2_copy,2,1
	.local	Sn_1_copy
	.comm	Sn_1_copy,2,1
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
.global	estat
	.data
	.type	estat, @object
	.size	estat, 1
estat:
	.byte	1
	.ident	"GCC: (GNU) 4.9.2"
.global __do_copy_data
.global __do_clear_bss
