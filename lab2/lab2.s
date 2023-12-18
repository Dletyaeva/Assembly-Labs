/*--------------------------------------------------------------------------------------
Name: 	Daleela Letyaeva
Date: 	08/31/2023
Course: CSCE 230 - Computer Organization
File: 	lab2.s
Lab:	Lab 2 - Basic Assembly Program

Purp:   An assembly program to find the minimum positive integer n such that function r3(n) is greater than 10
	as well as to learn basic syntax and structure in Nios II assembly programming

Doc: Jeffrey Falkinburg
     David Jordan
     Demetri Papageorge
     Utilized Lecture Notes for CH.2/Appendix B

Academic Integrity Statement: I certify that, while others may have
assisted me in brain storming, debugging and validating this program,
the program itself is my own work. I understand that submitting code
which is the work of other individuals is a violation of the honor
code. I also understand that if I knowingly give my original work to
another individual is also a violation of the honor code.
---------------------------------------------------------------------------------------*/
.text 
.global		_start
_start:
	movi	r2, 10
	movi	r3, 0
	movi	r4, 1
dowhile:
	movi	r5,1
forloop:
	add		r3, r3, r5
	addi	r5, r5, 1
	ble		r5, r4, forloop			#if r5 < r4 branch to forloop
	addi	r4, r4, 1
	ble		r3, r2, dowhile
	subi	r4, r4, 1
end:br	end
	.data
	.end