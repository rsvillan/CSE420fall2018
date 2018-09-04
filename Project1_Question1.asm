###########################################
# Project 1 
# Question 1
###########################################

###########################################
# Data Section to iniciate the variables
###########################################
.data 

# iniciating the variables 
string: .asciiz		"WELCOME TO COMPUTER ARCHITECTURE CLASS!"
newline: .asciiz 	"\n\n"


###########################################
# Instructions Start here
###########################################
.text

# Main Function
main:
	# Print the string In capital letters
	la $a0, string		#load the address of the string into a0
	li $v0, 4		#load system call number 4 to print what ever is in a0
	syscall 		#system call to print whatever is in a0
		
	# Newline
	la $a0, newline		#load the address of the newline into a0
	li $v0, 4		#load system call number 4 to print what ever is in a0
	syscall
	
	# set and Jump to UpperToLower function
	li $s0, 0		#load 0 in to s0 to know when to stop looop
	li $s1, ' '		#load a space into s1 to know when to skip
	li $s2, '!'		#loads an "!" into s2 to know when to skip
	la $a1, string		#load the address of the string into a0
	j spaceCheck		#jump to the loop that will make check if the character is a space

# checks to see if character is a space
spaceCheck:	
	addi $s0, $s0, 1		#add to s0 to keep track of strings
	
	# Traverse and check the string is a space
	lb $a0, 0($a1)		#load the first byte of a1 into a0; 1 byte = 1 character
	beq $a0, $s1, skipSpace	#go to skipSpace if the character is a space
	beq $a0, $s2, skipSpace	#go to skipSpace if the character is am "!"
	j upperToLower		#go to upperToLower if the charater isn't a space
	 
# converts the character to lowercase	 		
upperToLower:	
	addi $a0, $a0, 32	#add 0x20 to the character in a0
	addi $a1, $a1, 1		#add the number 1 to a0
	li $v0, 11		#load system call number 11 to print a character in a0
	syscall
	 
	# move on to the next character or exit the loop
	bne $s0, 39, spaceCheck
	
	# Jump to exit function
	j exit

# Changes the spaces or '!' back to normal 
skipSpace:
	subi $a0, $a0, 32	#subtract 0x20 to the character in a0
	j upperToLower
	
# Exit Function
exit:	
	# Exit the program
	li $v0, 10		#load system call 10 to exit program
	syscall		#system call to exit program