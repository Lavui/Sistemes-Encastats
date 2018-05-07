	.file	"serial_device.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	serial_init
	.type	serial_init, @function
serial_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(8)
	ldi r25,0
	sts 196+1,r25
	sts 196,r24
	sts 192,__zero_reg__
	ldi r24,lo8(24)
	sts 193,r24
	ret
	.size	serial_init, .-serial_init
.global	serial_get
	.type	serial_get, @function
serial_get:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L3:
	lds r24,192
	sbrs r24,7
	rjmp .L3
	lds r24,198
	ret
	.size	serial_get, .-serial_get
.global	serial_can_read
	.type	serial_can_read, @function
serial_can_read:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,192
	rol r24
	clr r24
	rol r24
	ret
	.size	serial_can_read, .-serial_can_read
.global	serial_put
	.type	serial_put, @function
serial_put:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L8:
	lds r25,192
	sbrs r25,5
	rjmp .L8
	sts 198,r24
	ret
	.size	serial_put, .-serial_put
	.ident	"GCC: (GNU) 4.9.2"
