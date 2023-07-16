.data
.word
first_ld: 18     # 2
second_ld: 0     # 8
third_ld: 64     # 0
fourth_ld: 121   # 1
fifth_ld: 64     # 0
sixth_ld: 2      # 6
seventh_ld: 121  # 1
eighth_ld: 64    # 0
HEX7_R: 0xFFFF202C
HEX6_R: 0xFFFF2028
HEX5_R: 0xFFFF2024
HEX4_R: 0xFFFF2020
HEX3_R: 0xFFFF201C
HEX2_R: 0xFFFF2018
HEX1_R: 0xFFFF2014
HEX0_R: 0xFFFF2010

.text
.globl _main
_main:
	lw $t0, first_ld
	sw $t0, HEX7_R

	lw $t0, second_ld
	sw $t0, HEX6_R

	lw $t0, third_ld
	sw $t0, HEX5_R

	lw $t0, fourth_ld
	sw $t0, HEX4_R

	lw $t0, fifth_ld
	sw $t0, HEX3_R

	lw $t0, sixth_ld
	sw $t0, HEX2_R

	lw $t0, seventh_ld
	sw $t0, HEX1_R

	lw $t0, eighth_ld
	sw $t0, HEX0_R
