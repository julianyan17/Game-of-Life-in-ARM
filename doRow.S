	.arch armv6
	.global doRow
	
	.cpu cortex-a53
	.equ 	NUL, 0
	.equ 	FP_OFFSET, 12	
	.text

doRow: 
	// PROLOG
	push	{r4-r5, fp, lr} 	// push saved registers (r4-r5, fp, lr)	into stack
	add 	fp, sp, #FP_OFFSET	// .


	// R0 holds pointer to destination 
	// R1 holds pointer to first cell to process
	// R2 holds pointer to last cell to process
	// R3 holds number of columns in the board
	
	mov r4, #0 				// r4 = 0; 
	add r2, r2, #1				// r2 = r2 + 1
	loop:
		cmp r1, r2			// if (r1 > r2)
		beq done  			// if (r1 <= r2); break;

		add r5, r1, #1			// r5 = r1 + 1
		ldrb r5, [r5]			// r5 = *(r5)
		add r4, r4, r5			// r4 = r4 + r5

		sub r5, r1, #1			// r5 = r1 - 1
		ldrb r5, [r5]			// *r5 
		add r4, r4, r5			// r4 = r4 + 5

		add r5, r1, r3			// r5 = r1 + r3 
		ldrb r5, [r5]			// r5 = *r5
		add r4, r4, r5			// r4 = r4 + 5

		sub r5, r1, r3			// r5 = r1 - r3
		ldrb r5, [r5]			// r5 = *r5
		add r4, r4, r5			// r4 = r4 + 5


		add r5, r1, r3			// r5 = r1 + r3
		sub r5, r5, #1			// r5 = r5 + 1
		ldrb r5, [r5]			// r5 = *r5
		add r4, r4, r5			// r4 = r4 + 5

		sub r5, r1, r3			// r5 = r1 + r3
		sub r5, r5, #1			// r5 = r5 + 1
		ldrb r5, [r5]			// r5 = *r5
		add r4, r4, r5			// r4 = r4 + 5

		sub r5, r1, r3			// r5 = r1 - r3
		add r5, r5, #1			// r5 = r5 + 1
		ldrb r5, [r5]			// r5 = *r5
		add r4, r4, r5			// r4 = r4 + 5

		add r5, r1, r3			// r5 = r1 + r3
		add r5, r5, #1			// r5 = r5 + 1
		ldrb r5, [r5]			// r5 = *r5
		add r4, r4, r5			// r4 = r4 + 5			
		
		ldrb r6, [r1]			// r6 = *r1

		cmp r6, #1			// if (r6 == 1)			
		bne value0			// else (r6 != 1)

		cmp r4, #0			// if (r4 == 0)
		bne aliveCells1			// else if (r4 != 0)
		mov r5, #0			// r5 = 0
		strb r5, [r0]			// *r0 = r5
		b end				// break
		aliveCells1: 
			cmp r4, #1		// if (r4 == 1)
			bne aliveCells2 	// else if (r4 != 1)
			mov r5, #0		// r5 = 0
			strb r5, [r0]		// *r0 = r5
			b end 			// break
		aliveCells2: 
			cmp r4, #2		// if (r4 == 2)
			bne aliveCells3		// if(r4 != 2)
			mov r5, #1		// r5 = 1
			strb r5, [r0]		// *r0 = r5
			b end 			// break
		aliveCells3: 
			cmp r4, #3		// if (r4 == 3)
			bne aliveCells4 	// if (r4 >= 3)
			mov r5, #1		// r5 = 0
			strb r5, [r0]		// *r0 = r5
			b end 			// break
		aliveCells4: 
			mov r5, #0		// r5 = 0
			strb r5, [r0]		// *r0 = r5
			b end			// break
		value0: 
			cmp r4, #3 		// if (r4 == 3)
			bne aliveCellsNot3	// if (r4 != 3)
			mov r5, #1		// r5 = 0
			strb r5, [r0]		// *r0 = r5
			b end			// break 
		aliveCellsNot3:
			mov r5, #0		// r5 = 0
			strb r5, [r0]		// *r0 = r5
			b end			// break
		end: 		
			add r1, r1, #1		// r1 = r1 + 1
			add r0, r0, #1		// r0 = r0 + 1
			mov r4, #0		// r4 = 0
			b loop 			// continue loop
	done: 
		// EPILOG
		sub	sp, fp, #FP_OFFSET
		pop 	{r4-r5, fp, lr} 	// pop from stack (r4-r5, fr,lr)
		bx 	lr			// return

