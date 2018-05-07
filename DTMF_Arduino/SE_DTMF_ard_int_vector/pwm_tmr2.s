	.file	"pwm_tmr2.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	setup_pwm_tmr2
	.type	setup_pwm_tmr2, @function
setup_pwm_tmr2:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	breq .L9
	sbi 0x4,3
	ldi r24,lo8(-125)
	sts 176,r24
	ldi r24,lo8(1)
	sts 177,r24
	ret
.L9:
	sbi 0xa,3
	ldi r24,lo8(35)
	sts 176,r24
	ldi r24,lo8(1)
	sts 177,r24
	ret
	.size	setup_pwm_tmr2, .-setup_pwm_tmr2
.global	set_pwm_tmr2
	.type	set_pwm_tmr2, @function
set_pwm_tmr2:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts 179,r24
	sts 180,r24
	ret
	.size	set_pwm_tmr2, .-set_pwm_tmr2
	.ident	"GCC: (GNU) 4.9.2"
