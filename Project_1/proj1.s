# proj1.s:  ECE 3504 Partial code to solve Project 1
# (this is the name of my program and matches file name) followed by description
# NAME: Soham Gandhi
# DATE: February 12, 4
# PURPOSE:  Project 1 for ECE 3504, Spring 2024
#
# REGISTER USAGE:   (this is where we decsribe the semantics of values within registers)
#	s0: stores the integer input from the keyboard
#	t0: stores the result of the next number in the sequence
#	a0: stores the address of prompt string (msg1 or msg2) (input parameter to syscall)
#	v0: syscall returns input values here
#
# ALGORITHM
#	If the number is non-positive, report an error message;
# 	Else 
# 		If the number is even, divide it by two and report the result;
# 		If the number is odd, triple it and add one and report the result;


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
	# If the input integer is not positive, print an error message and exit
	bgtz $s0, positive # if $s0 > 0, go to line PC + 5
	la $a0, msg3	# load address of msg3 into register
	li $v0, 4
	syscall		# make a syscall to print msg3 in console window

	# Exit gracefully w/ next 2 intructions using OS type system calls
	li $v0, 10
	syscall

	positive: # If the input integer is positive, calculate the next number in the sequence
		andi $t1, $s0, 1 # $t1 = $s0 & 1
		beqz $t1, even # if $t1 == 0, go to even

		# If the input integer is odd, triple it and add one
		sll $t0, $s0, 1 # $t0 = $s0 << 1
		add $t0, $t0, $s0 # $t0 = $t0 + $s0
		addi $t0, $t0, 1 # $t0 = $t0 + 1
		j print # go to print

		even: # If the input integer is even, divide it by 2
			srl $t0, $s0, 1 # $t0 = $s0 >> 1
			j print # go to print

	print:
		la $a0, msg2	# load address of msg2 into register
		li $v0, 4
		syscall		# make a syscall to print msg2 in console window
				
		li $v0, 1	# system call code for printing integer = 1
		move $a0, $t0	# move integer to be printed into $a0:  $a0 = $t0
		syscall		# call operating system to print the integer stored in $a0

	li $v0, 4	# system call code for printing a message = 4
	la $a0, msg4	# load address of msg4 into register
	syscall		# make a syscall to print msg4 in console window

	# counter for the number of steps
	li $t2, 0 # $t2 = 0

	hailstone: # Print the hailstone numbers
		andi $t1, $s0, 1 # $t1 = $s0 & 1
		beqz $t1, evenH # if $t1 == 0, go to even

		# If the input integer is odd, triple it and add one
		sll $t0, $s0, 1 # $t0 = $s0 << 1
		add $t0, $t0, $s0 # $t0 = $t0 + $s0
		addi $t0, $t0, 1 # $t0 = $t0 + 1
		j printH # go to print

		evenH: # If the input integer is even, divide it by 2
			srl $t0, $s0, 1 # $t0 = $s0 >> 1
			j printH # go to print

	printH:
		li $v0, 1
		move $a0, $t0
		syscall

		# increment the counter for the number of steps
		addi $t2, $t2, 1 # $t2 = $t2 + 1
		move $s0, $t0 # $s0 = $t0
		bne $t0, 1, hailstone # if $t0 != 1 go to hailstone

	li $v0, 4
	la $a0, msg5
	syscall

	li $v0, 1
	move $a0, $t2
	syscall

########################################
# Do not touch anything below this line.
########################################

	# Exit gracefully w/ next 2 intructions using OS type system calls
	li $v0, 10
	syscall

# END OF PROGRAM proj1.s