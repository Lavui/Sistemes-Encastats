	.file	"tmr0.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	setup_tmr0
	.type	setup_tmr0, @function
setup_tmr0:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,lo8(2)
	out 0x24,r25
	sts 110,r25
	out 0x27,r24
	cpi r22,64
	cpc r23,__zero_reg__
	breq .L3
	brsh .L4
	cpi r22,1
	cpc r23,__zero_reg__
	breq .L5
	cpi r22,8
	cpc r23,__zero_reg__
	brne .L2
	out 0x25,r25
	ret
.L4:
	cp r22,__zero_reg__
	ldi r24,1
	cpc r23,r24
	breq .L7
	cp r22,__zero_reg__
	sbci r23,4
	brne .L2
	ldi r24,lo8(5)
	out 0x25,r24
	ret
.L2:
	ldi r24,lo8(2)
	out 0x25,r24
	ret
.L7:
	ldi r24,lo8(4)
	out 0x25,r24
	ret
.L5:
	ldi r24,lo8(1)
	out 0x25,r24
	ret
.L3:
	ldi r24,lo8(3)
	out 0x25,r24
	ret
	.size	setup_tmr0, .-setup_tmr0
	.ident	"GCC: (GNU) 4.9.2"
