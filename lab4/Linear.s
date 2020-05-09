		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		MxPlusB
		.thumb_func
	// int32_t MxPlusB(int32_t x, int32_t mtop, int32_t mbtm, int32_t b);
	MxPlusB:
				PUSH	{R4}
				MUL		R1,R0,R1	// R1 = x * dvnd
				MUL		R0,R1,R2	// R0 = (x * dvnd) * dvsr
				ASR		R0,R0, 31	// R0 = R0 >> 31
				MUL		R0,R0,R2	// R0 = R0 * dvsr
				LSL		R0,R0, 1	// R0 = R0 << 1
				ADDS	R0,R0,R2	// R0 = R0 + dvsr
				LDR		R4, =2		// R4 = 2
				SDIV	R0,R0,R4	// R0 = R0 / 2
				ADDS	R0,R0,R1	// R0 = R0 + (x * dvnd)
				SDIV	R0,R0,R2	// R0 = R0 / dvsr
				ADDS	R0,R0,R3	// R0 = R0 + b
				POP		{R4}
				BX		LR
		.end