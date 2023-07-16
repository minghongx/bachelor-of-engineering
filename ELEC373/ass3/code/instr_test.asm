# lui ori
lui $s0, 0x0000
ori $s0, $s0, 0x0200

# sw lw

lui $s1, 0xAABB
ori $s1, $s1, 0xCCDD

sw $s1, 0x0000($s0)
lw $t0, 0x0000($s0)

# lb

lb $t0, 0x0000($s0)
lb $t0, 0x0001($s0)
lb $t0, 0x0002($s0)
lb $t0, 0x0003($s0)

# nor

lui $s1, 0xFF00
ori $s1, $s1, 0xF0F0  # Test data 0xFF00 F0F0

nor $t0, $s1, $zero  # Invert all bits; expect 0x00FF 0F0F

# xori

lui $s1, 0x7B41
ori $s1, $s1, 0x92C0  # Test data 0x7B41 92C0

xori $t0, $s1, 0x5730  # Expect 0x7B41 C5F0

# and or

lui $s1, 0xF0F0
ori $s1, $s1, 0xF0F0

lui $s2, 0x0F0F
ori $s2, $s2, 0x0F0F

and $t0, $s1, $s2  # Expect 0x0000 0000
or $t0, $s1, $s2   # Expect 0xFFFF FFFF

# slt

lui $s1, 0x6666
ori $s1, $s1, 0x6666

lui $s2, 0x7777
ori $s2, $s2, 0x7777

slt $t0, $s1, $s2  # Expect being set to 1

# addi, addiu, add, addu

lui $s1, 0x7FFF
ori $s1, $s1, 0xFFFF  # Max positive int in 2's complement

addi $t0, $s1, 0x0001  # Expect 0x8000 0000 with overflow
addiu $t0, $s1, 0x0001  # Expect 0x8000 0000 without overflow

lui $s2, 0x0000
ori $s2, $s2, 0x0001

add $t0, $s1, $s2  # Expect 0x8000 0000 with overflow
addu $t0, $s1, $s2  # Expect 0x8000 0000 without overflow

# sub, subu

lui $s1, 0x8000
ori $s1, $s1, 0x0000  # Min negative int in 2's complement

lui $s2, 0x0000
ori $s2, $s2, 0x0001

sub $t0, $s1, $s2  # Expect 0x7FFF FFFF with overflow
subu $t0, $s1, $s2  # Expect 0x7FFF FFFF without overflow

# beq

lui $s1, 0x6666
ori $s1, $s1, 0x6666  # Min negative int in 2's complement

lui $s2, 0x6666
ori $s2, $s2, 0x6666

beq $s1, $s2, GOTO
add $t0, $t0, $t0  # Random instr
GOTO:

# j

j End
add $t0, $t0, $t0  # Random instr
End:
