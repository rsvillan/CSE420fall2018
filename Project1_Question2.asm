###########################################
# Project 1 
# Question 2
###########################################

###########################################
# Data Section to iniciate the variables
###########################################

.data
strU:       .asciiz "Enter value for u variable "
strV:       .asciiz "Enter value for v variable: "
strCR:      .asciiz "\n"

###########################################
# Instructions Start here
###########################################

.text

# Main Function
main:
	la $a0, strU		#load first question in to a0
	li $v0, 4		#load syscall into v0
	syscall
	
	li $v0, 5		#load syscall into v0 to read integer
	syscall
	move $s0, $v0		#move user input into s0
	
	la $a0, strV		#load second question in to a0
	li $v0, 4		#load syscall into v0
	syscall
	
	li $v0, 5		#load syscall into v0 to read integer
	syscall
	move $s1, $v0		#move user input into s1
	
	#s0 has u
	#s1 has v
	#s2 is a
	#s3 is b
	#s6 is answer
	
	j math

#main math method 
math:
	move $s2, $s0		#move u into a
	move $s3, $s1		#move v into b
	jal aSquare		# s4 = u^2
	mul $s6, $s4, 3		# t0 = 3*(u^2)
	 
	jal aTimesB 		# s5 = u*v
	mul $t1, $s5, 7		# t1 = 7*u*v
			
	add $s6, $s6, $t1	# $t0 = (3*(u^2)) + (7*u*v)
							
	move $s2, $s1		# move v into a
	jal aSquare		# s4 = v^2
	
	sub $s6, $s6, $s4	# $t0 = (3*(u^2)) + (7*u*v) - (v^2)
	
	addi $s6, $s6, 1	# $t0 = (3*(u^2)) + (7*u*v) - (v^2) + 1
	
	move $a0, $s6		#load answer into a0
	li $v0, 1		#load syscall into v0
	syscall
	
	j exit
							
# square a ($s2) and returns s4	
aSquare:
	mul $s4, $s2, $s2		#a square into s4
	jr $ra

# multiplies a*b (s2*s3) and returns s5
aTimesB:
	mul $s5, $s2, $s3		#a times b into s5
	jr $ra
	
#exit routine	
exit:
	li $v0, 10		#load exit syscall
	syscall
	