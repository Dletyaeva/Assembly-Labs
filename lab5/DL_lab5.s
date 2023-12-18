/*--------------------------------------------------------------------------------------
Name: 	Daleela Letyaeva
Date: 	9/24/2023
Course: CSCE 230 - Computer Organization
File: 	DL_lab5.s
HW: 	Lab 5

Purp:    Learn how to read and write the input and output of DE10 Lite boards
	❖ 	 Learn the basic idea of processor polling
	❖ 	 Learn how to show a decimal number on seven-segment displays

Doc: 
Academic Integrity Statement: I certify that, while others may have
assisted me in brain storming, debugging and validating this program,
the program itself is my own work. I understand that submitting code
which is the work of other individuals is a violation of the honor
code. I also understand that if I knowingly give my original work to
another individual is also a violation of the honor code.
---------------------------------------------------------------------------------------*/
	.global _start
_start:
	movia r2, 0xFF200000 	/* red LED base address */
	movia r3, 0xFF200050 	/* pushbutton KEY base address */
	
	movia r4, 0xFF200040	#switch base address
	movia r5, 0xFF200020	#hex display
	movi  r10, 10
	movi  r12, 1
	movi  r20,0
	movi  r21,0
	movi  r22,0
	movi  r23,0
	
	
DO_DISPLAY:
#read sw and pb
	ldwio r6, 0(r3)		#load pushbuttons
	ldwio r7, 0(r4)		#load switches
	ldwio r8, 0(r5)		#load hex display
	ldwio r9, 0(r2)		#load led
	
#task1
	ldwio r9, 0(r2)			#load led
	slli  r6, r6, 8			#rotates left to line up with LEDR8 and LEDR9
	andi  r6, r6, 0x300
	stwio r6, 0(r2)			#write to LED8+i

#task2
	ldwio r9, 0(r2)		#load led
	ldwio r7, 0(r4)		#load switches
	andi  r7, r7, 0xFF	#bit mask LED8&9
	stwio r7, 0(r2)		#write to LED0-LED7	
	
#task3
	ldwio r8, 0(r5)		#load hex display
	ldwio r7, 0(r4)		#load switches
#lowest digit
	div		r14,  r7, r10
	mul		r13, r14, r10
	sub		r13, r7, r13		#HEX0
	call setDisDigit
	mov		r23, r13
	stwio	r23, 0(r5)
#second lowest	
	mov		r7, r14
	div		r14, r7, r10
	mul		r13, r14, r10
	sub		r13, r7, r13		#HEX1
	call setDisDigit
	mov		r22, r13
	slli	r22, r22, 8
	stwio	r22, 0(r5)
#third	
	mov		r7, r14
	div		r14, r7, r10
	mul		r13, r14, r10
	sub		r13, r7, r13		#HEX2
	call setDisDigit
	mov		r21, r13
	slli	r21, r21, 16
	stwio	r21, 0(r5)
#fourth
	mov		r13, r14
	call setDisDigit
	mov		r20, r13
	slli	r20, r20, 24
	stwio	r20, 0(r5)			#HEX3

	br DO_DISPLAY

setDisDigit:
	beq		r13, r0, if0 
	cmpeqi	r11, r13, 1
	beq		r11, r12, if1	
	cmpeqi	r11, r13, 2
	beq		r11, r12, if2
	cmpeqi	r11, r13, 3
	beq		r11, r12, if3
	cmpeqi	r11, r13, 4
	beq		r11, r12, if4
	cmpeqi	r11, r13, 5
	beq		r11, r12, if5
	cmpeqi	r11, r13, 6
	beq		r11, r12, if6
	cmpeqi	r11, r13, 7
	beq		r11, r12, if7
	cmpeqi	r11, r13, 8
	beq		r11, r12, if8
	cmpeqi	r11, r13, 9
	beq		r11, r12, if9	
back:
	ret
	

if0:
	movi	r13, 0x3F
	br back
if1:
	movi	r13, 0x06
	br back
if2:
	movi	r13, 0x5B
	br back
if3:
	movi	r13, 0x4F
	br back
if4:
	movi	r13, 0x66
	br back
if5:
	movi	r13, 0x6D
	br back
if6:
	movi	r13, 0x7D
	br back
if7:
	movi	r13, 0x07
	br back
if8:
	movi	r13, 0x7F
	br back
if9:
	movi	r13, 0x6F
	br back	
