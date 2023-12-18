#--------------------------------------------------------------------
#Name: Daleela Letyaeva
#Date: 09/06/2023
#Course: CSCE 230 - Computer Organization
#File: DL_lab3.s
#HW: Lab 3 - Assembly Array Programs
#Purp: This program is a demonstration in the basic syntax and
#structure in Nios II assembly programming by using arrays.

#Doc: <list the names of the people who you helped>
#     <Skirhr>

#Academic Integrity Statement: I certify that, while others may have
#assisted me in brain storming, debugging and validating this program,
#the program itself is my own work. I understand that submitting code
#which is the work of other individuals is a violation of the honor
#code. I also understand that if I knowingly give my original work to
#another individual is also a violation of the honor code.
#-------------------------------------------------------------------------*/
#I have a ton of branches - sue me, it works	
	.text               # located at address 0
    .global     _start
_start:
#------find max in array1
# r2, r3, r4, r9
	movi r9, 4            #assign the array size 		
    movi r2, 0              #init i = 0
	movi r4, 0				#temp max
	
findMax:

	ldbu  r3, array1(r2)     	#r2 is the index, r3 = value in index r2
	bltu r4, r3, maxUpdate		#if r4 < r3 then branch to maxUpdate
back1:	
	addi r2, r2, 1				#i++ (marks where we are in the array /loop)
    bltu r2, r9, findMax		#branch to 'forloop' if r2(current position in array1) < ARR1 (total size of array1)
	stb  r4, array1_max(r0)		#stores value of r4 in address of array1_max
    br findMin
	
maxUpdate:
	mov r4, r3					#move/copy value of r3 --> r4
	br back1 

#------find min in the array2
# r2, r5, r6, r9
findMin:
	movi r9, 6
	movi r2, 0              		#init i = 0
	ldh  r5, array2(r9)				#assign the first value of the array to temp min(r5)
	
findMin_L:
	ldhu  r6, array2(r2)
	bltu r6, r5, minUpdate				#if r6 < r5
back:
	addi r2, r2, 2					#i++
    bltu r2, r9, findMin_L		
	sth  r5, array2_min(r0)				#stores value of r6 in address of array2_min
	br findTotalOnesBits
	
minUpdate:
	mov r5, r6					#move/copy value of r6 --> r5
	br back						#br back to main loop
	
#------count total # of bit 1's from all elements in array3
findTotalOnesBits:
# r7-> r23 (avaliable)
	movi r11, 0		#sum
	movi r12, 12	#size of word array
	movi r13, 32	# number of bits in a word
	movi r9, 1		# 0x0001
	movi r2, 0		#int i = 0 for inner loop; needs to increment by 4
	movi r8, 0		#inner loop j = 0
		
	
#thing 1) get value from array3 index (main loop)
mainLoop:
	ldw r7, array3(r2)
	movi r8, 0				#reset value of r8 back to 0 before entering the innerloop again
	movi r9, 1				#reset value of r9
	br innerloop
backM:
	addi r2, r2, 4
	bltu r2, r12, mainLoop			#br to mainloop if r2 < r12(12)
	stw	 r11, array3_bitone(r0)		#else store value of r11 -> array3_bitone
	
end:br end  

#thing 2) count all the 1's (inner loop)
innerloop:
	and r10, r9, r7
	bne r10, r0, count_1s_Sum		#if r10 != 0 br to inner loop
backIn:	
	roli r9, r9, 1						#rotate left one bit
										#ex. 0001 -> 0010
	addi r8, r8, 1					#else i++				
	bltu r8, r13, innerloop			#if r8 < r13 (32) br to innerloop
	br backM						# else br back to mainloop
	
count_1s_Sum:
	addi r11, r11, 1
	br backIn
	
    .data               		# located at address 0x400

# data for the first array
array1:
    .byte       0x00, 0x11, 0x22, 0x33

array1_max:
    .byte 0

    .skip 3

# data for the second array
array2:
    .hword      0x0123, 0x4567, 0x89AB, 0xCDEF
array2_min:
    .hword 0

    .skip 2

# data for the third array
array3:
    .word       0x00112233, 0x44556677, 0x8899AABB				#word has 4 bytes, 1 byte = 8 bits
array3_bitone:
    .word 0
    .end
	
	



	
	