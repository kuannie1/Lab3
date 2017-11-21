# Compute the minimum of four numbers: 14, 5, 7, 10

addi $a0, $zero, 14 # arg0 = 14
addi $a1, $zero, 5  # arg1 = 5
addi $a2, $zero, 7  # arg2 = 7
addi $a3, $zero, 10 # arg3 = 10

main:
# Input operands
addi	$t0, $a0, 0		# SMALLEST element. Starts off as first argument
addi	$t1, $zero, 0		# stupid slt feature where you have to assign a boolean to signify true or not
# t1 -- whether slt returns 0 or 1
# t0 -- has the "current" smallest element

# see if second element is smaller than the current minimum
slt	$t1, $t0, $a1		# see if the second argument is smaller than the first element
bne	$t1, 1, reassignA1	# if $t1 isn't equal to 0, then a1 is smaller than t0, so we need to reassign t0

# see if third element is smaller than current minimum
slt 	$t1, $t0, $a2		# see if the third argument is smaller than the first element
bne 	$t1, 1, reassignA2	# if $t1 isn't equal to 0, then a2 is smaller than t0, so we need to reassign t0

# see if fourth element is smaller than current minimum
slt 	$t1, $t0, $a3		# see if the fourth argument is smaller than the first element
bne 	$t1, 1, reassignA3	# if $t1 isn't equal to 0, then a3 is smaller than t0, so we need to reassign t0

# if a0 made it this far, break the loop
j 	breakloop


reassignA1:
addi 	$t0, $a1, 0		# SMALLEST element. Updated to a1 instead
slt	$t1, $t0, $a2		# see if the third element is smaller than the second element
bne 	$t1, 1, reassignA2	# if $t1 isn't equal to 0, then a2 is smaller than t0, so we need to reassign t0

# see if fourth element is smaller than current minimum
slt 	$t1, $t0, $a3		# see if the fourth element is smaller than the second element
bne 	$t1, 1, reassignA3	# if $t1 isn't equal to 0, then a3 is smaller than t0, so we need to reassign t0

# if a1 made it this far, break the loop
j	breakloop


reassignA2:
addi 	$t0, $a2, 0		# SMALLEST element. Updated to a2 instead
slt	$t1, $t0, $a3		# see if the fourth element is smaller than the second element
bne 	$t1, 1, reassignA3	# if $t1 isn't equal to 0, then a3 is smaller than t0, so we need to reassign t0

# if a2 made it this far, break the loop


reassignA3:
addi 	$t0, $a3, 0		# SMALLEST element. Updated to a3 instead

# if a3 is the minimum, break the loop


#  return the answer in register v0
breakloop:
add $v0, $zero, $t0
