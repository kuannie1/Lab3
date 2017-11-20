# Test BNE instruction

addi $s0, $zero, 6
addi $s1, $zero, 8
label: sub $s2, $s0, $s1
bne $s0, $s1, label