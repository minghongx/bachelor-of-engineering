  AREA asm_func, CODE, READONLY
	THUMB
	; Export exp26_asm function location so that C compiler can find it and link
    EXPORT exp26_asm
exp26_asm	PROC
	; Test routine that does something!

	ADDS r7, r0, r1  ;
	
	; Some arithmetic
	
	MOVS r2, #14		;move a number into reigister 2	
	MOVS r3, #37		;move a 2nd no. into reg. 3
	
	ADDS r4, r2, #7	;put sum of reg.2 and 7 in reg.4
	
	ADDS r5, r2, r3	;put sum of r2 and r3 in r5
	ADDS r6, r3, r2	;reverse the order 
	
	SUBS r0, r2, #1	;subtract 1 from r2

	SUBS r1, r2, r3	;subtract r3 from r2
	SUBS r2, r3, r2	;reverse the order
	
	; Some logic
	
	MOVS r2, #0x0011		;set bit pattern 0011 (in hex)
	MOV r3, r2
	ADDS r3, #0x00F0	;set bit pattern 0101 (in hex)
	
	MOV r4, r2
	ANDS r4, r3		;AND
	MOV r5, r2
	ORRS r5, r3		;OR
	MOV r6, r2
	EORS r6, r3		;exclusive OR
	MOV r0, r2
	BICS r0, r3		;bit clear
	MOV r1, r3
	BICS r1, r2		;bit clear in reverse order
	
	; Some unconditional branches
	
	MOVS r2, #0		;clear register 2
loop1	
	ADDS r2, r2, #1	;increment register 2
	B loop1			;loop always
		
	MOVS r2, #0		;clear register 2		
loop2	
	ADDS r2, r2, #1	;increment register 2
	ADDS r0, r0, #0	;do nothing
	B loop2			;loop always
	
	MOVS r2, #0		;clear register 2
loop3	
	ADDS r2, r2, #1	;increment register 2
	ADDS r0, r0, #0	;do nothing
	ADDS r0, r0, #0	;do nothing
	B loop3			;loop always
	
	; Setting and clearing flags
	
	MOVS r2, #0			;clear r2 and set/clear flags
	MOVS r3, #1			;set value in r3 to 1
	
	MOV r4, r2			;move r2 to r4
	MOVS r4, r2			;same as previous instruction but set/clear flags
	
	ADDS r5, r2, r3		;add r2 and r3 and set flags
	
	SUBS r6, r2, r3		;r6:= r3 - r2 and set flags
	
	; Conditional branching
	
	LDR r0, =0x7F000000	;set value in r0
	LDR r1, =0x81000000	;set value in r1
	MOVS r2, #3		;set value in r2
	MOVS r3, #7		;set value in r3
	MOVS r4, #0		;set value in r4 to 0
	MOVS r5, #0		;set value in r5 to 0
	MOV r8, r5		;set value in r8 to 0
	MOV r9, r5		;set value in r9 to 0
	
	ADDS r6, r1, r0		;add r1 and r0 and set/clear flags
	
	BEQ next1			;branch if zero flag set
	ADD r4, r2		;add if zero flag clear
next1	

	BNE next2			;branch if zero flag clear
	ADD r4, r3		;add if zero flag set
next2	

	BCS next3			;branch if carry flag set
	ADD r5, r2		;add if carry flag clear
next3

	BCC next4			;branch if carry flag clear
	ADD r5, r3		;add if carry flag set
next4	

	BMI next5			;branch if negative flag set
	ADD r8, r2		;add if negative flag clear
next5

	BPL next6			;branch if negative flag clear
	ADD r8, r3		;add if negative flag set
next6	

	BVS next7			;branch if overflow flag set
	ADD r9, r2		;add if overflow flag clear
next7

	BVC last		;branch if overflow flag clear
	ADD r9, r3		;add if overflow flag set
last
		
	; return value passed back to C in r0
	MOVS r0, r7
	
	; Return to C using link register (Branch indirect using LR - a return)
	BX      LR
	
	ENDP
	
    END