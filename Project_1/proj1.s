# proj1.s:  ECE 3504 Partial code to solve Project 1
# (this is the name of my program and matches file name) followed by description
# NAME: 
# DATE: 
# PURPOSE:  Project 1 starting code
#
# REGISTER USAGE:   (this is where we decsribe the semantics of values within registers)
#	s0: stores the integer input from the keyboard
#	t0: stores the result of the next number in the sequence
#	a0: stores the address of prompt string (msg1 or msg2) (input parameter to syscall)
#	v0: syscall returns input values here
#
#
# ALGORITHM
#	(left for you to understand)
# (everything above is for the human and is strictly readable text for the human to understand)

	# assembler directive to describe the "main" as a global label
	.globl main

	.data	# Data declaration section (Here is where variables and stored data exist)

msg1:	.asciiz		"Enter a positive integer: "
msg2:	.asciiz		"The next integer in the sequence is: "
msg3:	.asciiz		"The entered integer shall be positive. "
msg4:	.asciiz		"The hailstone numbers are: "
msg5:	.asciiz		"The number of steps is: "

	.text   # Text region - user instructions (your code)
	
main:		# Start of code section

	# all of your assembly code instructions go here
	la $a0, msg1		# load address of msg1 into register
	li $v0, 4		# system call code for printing a message = 4
	syscall			# make a syscall to print msg1 in the console	
	
	# read integer into $s0
    	li	$v0, 5		# system call code for read integer = 5
    	syscall			# call operating system to read an integer from the console
	# value read from keyboard returned in register $v0
    	add $s0, $zero, $v0	# move $v0 to $s0, now $s0 equals the input integer

########################################
# Do not touch anything above this line.
# Write your program below this line.
########################################



	la $a0, msg2	# load address of msg2 into register
	li $v0, 4
	syscall		# make a syscall to print msg2 in console window
			
    	li $v0, 1	# system call code for printing integer = 1
    	move $a0, $t0	# move integer to be printed into $a0:  $a0 = $t0
    	syscall		# call operating system to print the integer stored in $a0

########################################
# Do not touch anything below this line.
########################################

	# Exit gracefully w/ next 2 intructions using OS type system calls
	li $v0, 10
	syscall

# END OF PROGRAM proj1.s