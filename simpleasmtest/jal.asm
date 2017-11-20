# Test JAL instruction

addi $s0, $zero, 2

loop:
	addi $s0, $s0, 2
jal loop