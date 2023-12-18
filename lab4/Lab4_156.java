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
	 movia r2, array1
	 subi sp, sp, 4
	 stw r2, (sp) 				#;push address of array1
	 ldw r2, array1_size(r0)
	 subi sp, sp, 4
	 stw r2, (sp) 				#;push size of array1
	 subi sp, sp, 4 			#;space for return value
	 call sum
	 ldw r2, (sp) 				#;get return value
	 addi sp, sp, 12 			#; pop input and return
	
#;used to test your function compare
	 movia r3, array1
	 subi sp, sp, 4
	 stw r3, (sp) 				#;push address of array1
	 ldw r3, array1_size(r0)
	 subi sp, sp, 4
	 stw r3, (sp) 				#;push size of array1
	 movia r3, array2
	 subi sp, sp, 4
	 stw r3, (sp) 				#;push address of array2
	 ldw r3, array2_size(r0)
	 subi sp, sp, 4
	 stw r3, (sp) 				#;push size of array2
	 subi sp, sp, 4 			#; space for return value
	 call compare
	 ldw r3, (sp) 				#; get return value
	 addi sp, sp, 20			#; pop input and return

end:br end


# ;write your function sum below
sum:
	subi 	sp, sp, 12			#;store initial value of registers
	stw 		r5, 8(sp)
	stw 		r6, 4(sp)
	stw 		r4, (sp)
	
	ldw  	r5, array1_size(r0)				#;load the number of elements in array1 
	muli 	r5, r5, 4				#;total size in bytes
	subi	r5, r5, 4				#accounting for 0 indexing
	movi 	r6, 0					#;int i=0; -> needs to be a multiple of 4 (word)
	movi 	r2, 0					#;temp sum	
loop:
	ldw  	r4, array1(r6)			#;load the current value of array1 at current address
	add 		r2, r2, r4
	addi 	r6, r6, 4				#;increment index
	bleu 	r6, r5, loop				#;if r6 < r5 (size of array1) --> loop
	
	ldw	 	r4, (sp)
	addi 	sp, sp, 4
	ldw 		r6,(sp)
	addi 	sp, sp, 4
	ldw		r5, (sp)
	addi	sp, sp, 4
	ret
 
# ;write your function compare below
compare:
	subi	sp,sp, 4
	stw 		ra, (sp)
	
	subi 	sp, sp, 4
	stw 		r2, (sp)
	
	subi	sp, sp, 4
	stw		r7, (sp)			#;register for array 1 sum
	
	subi 	sp, sp, 4
	stw		r8, (sp)			#;register for array 2 sum
	
	movi	r7, 0
	
	call sum
	mov		r7, r2
		
	movi	r8, 0
	
	call sum
	mov		r8, r2
	
	bleu	r7, r8, if			#;compare  if (r7) sumAr1 <=  (r8)sumAr2
	
	movi 	r3, 0
	ldw		r8, (sp)
	
	addi 	sp, sp, 4
	ldw		r7, (sp)
	 
	 addi	sp, sp, 4
	 ldw		r2, (sp)
	 
	addi	sp, sp, 4
	ldw		ra, (sp)
	ret
 
 if:
	movi 	r3, 1
	ldw		r8, (sp)
	
	addi 	sp, sp, 4
	ldw		r7, (sp)
	 
	 addi	sp, sp, 4
	 ldw		r2, (sp)
	 
	addi	sp, sp, 4
	ldw		ra, (sp)
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