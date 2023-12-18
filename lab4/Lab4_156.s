	.text
	 .global _start
	 
#; Main program
_start:
	 movia sp, 0x500
	#; used to test whether your subroutines modify these registers
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
	 
 #;used to test your function sum
	 movia 	r2, array1
	 subi 	sp, sp, 4
	 stw 	r2, (sp) 			#;push address of array1
	 ldw 	r2, array1_size(r0)
	 subi 	sp, sp, 4
	 stw 	r2, (sp) 			#;push size of array1
	 subi 	sp, sp, 4 			#;space for return value
	 call sum
	 ldw 	r2, (sp) 			#;get return value
	 addi 	sp, sp, 12 			#; pop input and return
	
#;used to test your function compare
	 movia 	r3, array1
	 subi 	sp, sp, 4
	 stw 	r3, (sp) 			#;push address of array1
	 ldw 	r3, array1_size(r0)
	 subi 	sp, sp, 4
	 stw 	r3, (sp) 			#;push size of array1
	 movia 	r3, array2
	 subi 	sp, sp, 4
	 stw 	r3, (sp) 			#;push address of array2
	 ldw 	r3, array2_size(r0)
	 subi 	sp, sp, 4
	 stw 	r3, (sp) 			#;push size of array2
	 subi 	sp, sp, 4 			#; space for return value
	 call compare
	 ldw 	r3, (sp) 			#; get return value
	 addi 	sp, sp, 20			#; pop input and return

end:br end


# ;write your function sum below
sum:
	stw	r4, -36(sp)		#--> address for each element
	stw	r5, -32(sp)		#--> number of elements
	stw	r6, -28(sp)		#--> sum
	stw	r7, -24(sp)		#--> access the value at memory r4
	
	ldw	r4, 8(sp)		#loading the address of array from stack onto r4
	ldw	r5, 4(sp)		#loading the # of elements of an array from stack onto r5
	muli   	r5, r5, 4		# multiplying the # of elements by their size (word or 4 bytes) 
	add	r5, r5, r4		#--> act as max # of times to repeat 
	subi	r5, r5, 4
	mov	r6, r0 
loop:
	ldw	r7, 0(r4)		#load the value from memory address r4 into r7
	add	r6, r6, r7
	addi	r4, r4, 4
	bleu	r4, r5, loop
	
	stw 	r6,(sp)
	
	ldw	r4, -36(sp)		
	ldw	r5, -32(sp)		
	ldw	r6, -28(sp)		
	ldw	r7, -24(sp)		
	ret
 
# ;write your function compare below
compare:
	stw 	ra, -4(sp)
	stw	r8, -8(sp)		#array2
	stw	r9, -12(sp)		#array1
	
	call sum
	ldw	r8, (sp)
	
	addi 	sp, sp, 8
	ldw	r3, (sp) 		#this is storing a preexisting value at that location
	call sum
	ldw	r9, (sp)
	stw 	r3, (sp)		#restoring the value that was initially in stack
	subi	sp, sp, 8		#stack pointing at the return slot value
	
	bleu	r8, r9, if		#;compare  if (r8) sumAr2 <=  (r9)sumAr1
	stw	r0, (sp)
	ldw 	ra, -4(sp)
	ldw	r8, -8(sp)		#array2
	ldw	r9,	-12(sp)		#array1
	ret
 
 if:
 	movi	r8, 1
	stw 	r8, (sp)
	ldw 	ra, -4(sp)
	ldw	r8, -8(sp)		#array2
	ldw	r9, -12(sp)		#array1
	ret
	


 
#;data section is located at address 0x400
.data
array1:
	.word 1, 3, 5, 7, 9, 11, 13
array1_size:
	.word 7
array2:
	.word 16, 17, 18
array2_size:
	.word 3