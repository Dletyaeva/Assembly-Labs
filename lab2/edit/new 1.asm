	.text
	 .global _start
	 
# Main program
_start:
	 movia sp, 0x500
	# used to test whether your subroutines modify these registers
	 movi r2, 2
	 movi r3, 3
	 movi r4, 4
	 movi r5, 5
	 movi r6, 6
	 movi r7, 7
	 movi r8, 8
	 movi r9, 9
	 movi r10, 10
	 movi r11, 11
	 movi r12, 12
	 movi r13, 13
	 movi r14, 14
	 movi r15, 15
	 movi r16, 16
	 movi r17, 17
	 movi r18, 18
	 movi r19, 19
	 movi r20, 20
	 movi r21, 21
	 movi r22, 22
	 movi r23, 23
	 
 # used to test your function sum
	 movia r2, array1
	 subi sp, sp, 4
	 stw r2, (sp) 		# push address of array1
	 
	 ldw r2, array1_size(r0)
	 subi sp, sp, 4
	 stw r2, (sp) 		# push size of array1
	 
	 subi sp, sp, 4 	# space for return value
	 call sum
	 ldw r2, (sp) 		# get return value
	 addi sp, sp, 12 	# pop input and return
	
end:br end


# write your function sum below
sum:		
	movi r4, 0				#int i = 0;
	movi r5, 0				#temp sum
	mul  r2, 4				#total size

loop:
	ldw 	r6, array1(r4)		#load current index of array1 onto r6
	add 	r5, r5, r6
	addi 	r4, r4, 4			#i++
	ble 	r4, r2, loop		#if r4 < r2 (size of array1) --> sum
	stw 	r5, (sp)			#store value of r5 onto stack
	ret


# data section is located at address 0x400
.data
array1:
	.word 1, 3, 5, 7, 9, 11, 13
array1_size:
	.word 7