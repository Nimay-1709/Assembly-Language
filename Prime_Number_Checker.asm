# File Name: Prime_Number_Checker.asm
# Author Name: Nimay Patel
# Purpose: It checks if the number is between 0 and 1000 and
# tells if a number is prime or not and exits when 0 is pressed

.text
main:
 # This block prompts to enter value of n
 li 	$v0,4			# Load 4 into $v0 to indicate a print command.
 la 	$a0,I_message		# Load the purpose string.
 syscall 			# Print the message.

 # This block accepts input for n
 li 	$v0,5			# Load 5 to indicate the Input command.
 syscall 			# The Input is accepted
 add 	$s7, $zero, $v0		# Store the inputed value in $t0

 beqz $s7, exit

 # This block checks whether number is valid or not
 # if (n < 0 )
 slti 	$t8, $s7, 0

 # if (n > 1000 )
 sgt 	$t7, $s7, 1000

 # if ((n < 0 ) || (n > 100 ))
 or 	$t6, $t8, $t7
 beqz $t6, prime_check
 li 	$v0,4			# Load 4 into $v0 to indicate a print command.
 la 	$a0,O_Invalid		# Load the purpose string.
 syscall 			# Print the message.
 b main

 prime_check:
 add	$a0, $s7, $zero
 jal	is_prime		# Send the number to the procedure!
 add	$s6, $zero, $v0		# Send the result as an argument to...
 seq 	$t9, $s6, 1
 beqz 	$t9, else
 li	$v0, 4  		# ...print integer onscreen
 la 	$a0, O_Prime
 syscall
 b main

 else:
 li	$v0, 4  		# ...print integer onscreen
 la 	$a0, O_NotPrime
 syscall
 b main

 exit:
 li	$v0, 10			# exit the program
 syscall

 ## Tells if a number is prime
 # $a0	The number to check if it's prime
 # $v0	1 if the number is prime, 0 if it's not
 is_prime:
	addi	$t0, $zero, 2				# int x = 2

 is_prime_test:
	slt	$t1, $t0, $a0				# if (x > num)
	bne	$t1, $zero, is_prime_loop
	addi	$v0, $zero, 1				# It's prime!
	jr	$ra						# return 1

 is_prime_loop:						# else
	div	$a0, $t0
	mfhi	$t3						# c = (num % x)
	slti	$t4, $t3, 1
	beq	$t4, $zero, is_prime_loop_continue	# if (c == 0)
	add	$v0, $zero, $zero				# its not a prime
	jr	$ra							# return 0

 is_prime_loop_continue:
	addi $t0, $t0, 1				# x++
	j	is_prime_test				# continue the loop

 .data
 I_message: .asciiz "Enter the number to check: -  "
 O_Prime: .asciiz "The Entered Number is a Prime Number.\n"
 O_NotPrime: .asciiz "The Entered Number is Not a Prime Number.\n"
 O_Invalid: .asciiz "Invalid Output.\n "
