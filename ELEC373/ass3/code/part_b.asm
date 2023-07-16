### nor

# Test data 0xFF00 F0F0
lui $t0, 0xFF00
ori $t0, $t0, 0xF0F0

nor $t1, $t0, $zero  # Invert all bits; expect 0x00FF 0F0F



### xori

# Test data 0x7B41 92C0
lui $t0, 0x7B41
ori $t0, $t0, 0x92C0

xori $t1, $t0, 0x5730  # expect GPR 1 contains 0x7B41 C5F0



### lb

# Store test data 0xAABB CCDD to GPR 9
lui $t9, 0x0000
addiu $t9, $t9, 0x0200
lui $t0, 0xAABB
ori $t0, $t0, 0xCCDD
sw $t0, 0x0000($t9)

lb $t1, 0x0000($t9)
lb $t2, 0x0001($t9)
lb $t3, 0x0002($t9)
lb $t4, 0x0003($t9)
