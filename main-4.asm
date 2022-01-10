;
; smart_idiot_light.asm
;
; Created: 9/22/2021 5:23:15 PM
; Author : vish7
;


; Replace with your application code
	start:
	ldi r16, 0xFF		;load r16 with all 1s
	out VPORTD_DIR, r16		;set VPORTD to output
	ldi r16, 0x00		;load r16 with all 0s
	out VPORTD_OUT, r16		;set VPORTD to output all 0s
	out VPORTC_DIR, r16		;set VPORTC to input
	out VPORTC_OUT, r16		;set VPORTC to input all 0s

	loop:
	in r16, VPORTC_IN	;read in the input value, store in r16
	mov r18, r16		;image of the inputs
	cpi r18, 0xC3		;compare with the minimum green temp
	brlo yellow
	cpi r18, 0xDD		;compare with the minimum red temp
	brsh red

	green:
	ldi r17, 0xC0		;store the color on the register
	rjmp output

	red:
	ldi r17, 0x60		;store the color on the register
	rjmp output

	yellow:
	ldi r17, 0x40		;store the color on the register
	rjmp output

	output:
	out VPORTD_OUT, r17	;output the color to the LED
	rjmp loop
