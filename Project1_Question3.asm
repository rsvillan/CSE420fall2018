###########################################
# Project 1 
# Question 3
# Answer sum = 165
###########################################

###########################################
# Data Section to initiate the variables
###########################################
.data 

# initiating the variables 
print: 		.asciiz		"Sum = "
sum: 		.word 0: 1		#1 word
newline: 	.asciiz 	"\n\n"

###########################################
# Instructions Start here
###########################################
.text

# Main Function
	# s0 is initial pointer positon
	# s1 is i
	# s2 is sum
	#s3 is sumPTR
	
main:
	addi $sp, $sp, -40	# create space for 10 ints
	la $s0, ($sp) 		# initial pointer will be at s0
	
	li $s2, 0		# s2 = 0
	sw $s2, sum		# sum = 0
	la $s3, sum		# *sumPTR = &sum
	
	li $s1, 0		# this is i for forloop
	j loop1			# jump to loop 1
	
loop1:
	bge $s1, 10, refresh 	# if i >= 10, goto loop 2
	
	addi $t0, $s1, 1	# t0 = i + 1
	mul $t0, $t0, 3		# t0 = 3(i+1)
	
	sw $t0, 0($sp)		# save to into array[i]
	addu $sp, $sp, 4	# increase the pointer
	
	add $s1, $s1, 1		# increment s1 by 1
	j loop1			# loop to top
	
refresh:
	li $s1, 0		# this is i for forloop
	la $sp, ($s0)		# set stackpointer back to it's original place
	j loop2
	
loop2:
	bge $s1, 40, exit 	# if i >= 10, goto exit
	la $sp, 0($s0)		# set stackpointer back to it's original place
	
	addu $sp, $sp, $s1	# array + i
	jal updateSum
	
	add $s1, $s1, 4		# increment s1 by 1
	j loop2			# loop to top
	
#this adds the sum to the total
updateSum:
	lw $t0, 0($sp)		# load from memory into t0
	lw $t1, 0($s3)		# load word from memory in address s3
	
	add $t2, $t1, $t0	# total += element
	sw $t2, 0($s3)		# store total into s3
	
	jr $ra			#jump back into the original jump

#exit routine
exit:
	la $a0, print		# load address of s2 (sum)
	li $v0, 4		# load syscall 4 ( for strings)
	syscall
	
	lw $a0, sum		# load address of s2 (sum)
	li $v0, 1		# load syscall 4 ( for strings)
	syscall
	
	li $v0, 10		#load exit syscall
	syscall
	
