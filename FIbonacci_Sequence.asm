# Program File: Patel_Nimay_Programming04.asm
# Author: Nimay Patel
# This program will accept values for n and compute Fibonacci sequence till that number using arrays
.text
main:	
        # This block prompts to enter value of n
 	li $v0,4			# Load 4 into $v0 to indicate a print command.
 	la $a0,N_message		# Load the purpose string.
 	syscall 			# Print the message.

	li	$v0, 5		# read integer from input. The read integer will be stroed in $v0
	syscall
	add $t0, $v0, $zero
 	li $v0, 4
	la $a0, O_message
	syscall
	
	add	$a0, $t0, $zero
	add	$a1, $zero, 4
	jal allocate_memory
	add 	$a0, $t0, $zero
	move 	$a1, $v0
	jal fib_compute
	
.data
N_message: .asciiz "\nPlease enter an input : "
O_message: .asciiz "\nThe Fibonacci Sequence is : "

# Subprogram: allocate_array
# Purpose: To allocate an array of $a0 items, each of size $a1.
# Author: Nimay Patel
# Input: $a0 - the number of items in the array, $a1 - the size of each item
# Output: $v0 - Address of the array allocated	
.text
allocate_memory:
 addi $sp, $sp, -4
 sw $ra, 0($sp)
 mul $a0, $a0, $a1
 li $v0, 9
 syscall	
 
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 jr $ra

# SubProgram: fib_compute
# Purpose: Compute a number in fibonacci sequence
# Author: Nimay Patel
# Input: the value of n
# Output: The number in fibonacci sequence as long as it is less than n.
.text
fib_compute:
	li 	$t7, 0
	add 	$t6, $a1, $zero
	move 	$s5, $a0
	sub 	$s5, $s5, 1
	beq	$s5, 0, is1
	beq	$s5, 1,	is1
	li	$s4, 1		# the counter which has to equal to $v0	
	li	$s0, 1
	li	$s1, 1
	li	$v0, 1
	add	$a0, $s0, $zero
	syscall
	li	$v0, 4
	la	$a0, space
	syscall
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	li	$v0, 4
	la	$a0, space
	syscall
 
loop:	add	$s2, $s0, $s1
	addi	$s4, $s4, 1
	beq	$s5, $s4, iss2
	li	$v0, 1
	add	$a0, $s2, $zero
	syscall
	li	$v0, 4
	la	$a0, space
	syscall
	
	add	$s0, $s1, $s2
	addi	$s4, $s4, 1
	beq	$s5, $s4, iss0
	li	$v0, 1
	add	$a0, $s0, $zero
	syscall 
	li	$v0, 4
	la	$a0, space
	syscall
	
	add	$s1, $s2, $s0
	addi	$s4, $s4, 1
	beq	$s5, $s4, iss1
	li	$v0, 1
	add	$a0, $s1, $zero
	syscall
	li	$v0, 4
	la	$a0, space
	syscall
	
	b 	loop
 
iss0:	move	$a0, $s0	
	b	print
 
iss1:	move	$a0, $s1	
	b	print	
 
iss2:	move	$a0, $s2	
	b	print
 
 
is1:	li	$a0, 1
	b 	print
 
print:	
	li	$v0, 1
	syscall
	li $v0, 10
	syscall
	
.data
space: .asciiz ",\t "