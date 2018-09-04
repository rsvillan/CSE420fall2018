.data
stringI:    .asciiz "Enter the value of i: "
stringX:    .asciiz "Enter the value of x: "
output:     .asciiz "The output of compute(i,x) is "
.text
    .globl main
    
main:
    li  $v0, 4      # Enter value of i
    la  $a0, stringI    
    syscall 
    
    li  $v0, 5      # Enter i
    syscall
    
    move    $s0, $v0    
    
    li  $v0, 4      # Enter value of x
    la  $a0, stringX
    syscall 
    
    li  $v0, 5      # Enter x
    syscall
    
    move    $s1, $v0    
    
    move    $a0, $s0    
    move    $a1, $s1
    jal compute
    move    $s2, $t0
    
    li  $v0, 4      # execute compute(i,x) to output
    la  $a0, output
    syscall 
    
    li  $v0, 1      # print
    move    $a0, $s2
    syscall
    
    li  $v0, 10     # exit
    syscall
    
compute: 
    addi    $sp, $sp, -8
    sw  $ra, 0($sp)
    ble $a1, 0, elseif  # if x > 0, otherwise branch to else if
    add $a1, $a1, -1    # (x-1)
    addi    $t0, $t0, 1 # compute (i, x-1) + 1
    
    jal compute
    addi    $sp, $sp, 8 # increment by 8
    lw  $ra, 0($sp)
    jr  $ra
    
elseif:
    addi    $sp, $sp, -8    # stack
    sw  $ra, 0($sp)
    ble $a0, 0 else
    add     $a0, $a0, -1    # i - 1
    move    $a1, $a0
    addi    $t0, $t0, 5 # compute (i-1, i-1) + 5
    jal compute
    addi    $sp, $sp, 8 #increment by 8
    lw  $ra, 0($sp)
    jr  $ra
    
else:
    addi    $sp, $sp, -8    # stack
    swl $ra, 0($sp)
    addi    $t0, $t0, 1 # 1
    addi    $sp, $sp, 8
    lw  $ra, 0($sp) # return 1
    jr  $ra 