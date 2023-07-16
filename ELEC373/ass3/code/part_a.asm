# MIPS has a 32-bit word size (4 bytes) and a 32-bit address space.
# https://stackoverflow.com/questions/13160930/load-32-bit-constant-to-register-in-mips
# https://stackoverflow.com/questions/25301769/what-is-the-use-of-ori-in-this-part-of-mips-code
# https://stackoverflow.com/questions/19827522/difference-between-move-and-li-in-mips-assembly-language
# https://stackoverflow.com/questions/4023026/mips-curiosity-faster-way-of-clearing-a-register

.text
.globl _main
_main:
	# Construct the HEX0_R reg addr in GPR 1
	lui $t1, 0xFFFF  # Upper half addr
	ori $t1, $t1, 0x2010  # Lower half addr

	# Clear the upper 16 bits of GPR 0
	lui $t0, 0x0000

	# Set the lower 16 bits of GPR 0
	ori $t0, $zero, 0x0024  # decimal 2
	sw $t0, 0x0000($t1)  # Store the decimal 0 into the HEX0_R reg

	ori $t0, $zero, 0x0000  # decimal 8
	sw $t0, 0x0004($t1)  # Store the decimal 1 into the HEX1_R reg

	ori $t0, $zero, 0x0040  # decimal 0
	sw $t0, 0x0008($t1)  # Store the decimal 6 into the HEX2_R reg

	ori $t0, $zero, 0x0079  # decimal 1
	sw $t0, 0x000C($t1)  # Store the decimal 0 into the HEX3_R reg

	ori $t0, $zero, 0x0040  # decimal 0
	sw $t0, 0x0010($t1)  # Store the decimal 1 into the HEX4_R reg

	ori $t0, $zero, 0x0002  # decimal 6
	sw $t0, 0x0014($t1)  # Store the decimal 0 into the HEX5_R reg

	ori $t0, $zero, 0x0079  # decimal 1
	sw $t0, 0x0018($t1)  # Store the decimal 8 into the HEX6_R reg

	ori $t0, $zero, 0x0040  # decimal 0
	sw $t0, 0x002C($t1)  # Store the decimal 2 into the HEX7_R reg
