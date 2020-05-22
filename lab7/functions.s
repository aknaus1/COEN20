//f = k + [(13m - 1) / 5] + D + (D / 4) + (C / 4) - 2C
//k: day of the month, March is 1, April is 2, and so on to February, which is 12.
//D: last 2 digits of the year
//C: the century - first 2 digits of the year
       
        .syntax		unified
		.cpu		cortex-m4
		.text
		

        //uint32_t Zeller1(uint32_t k, uint32_t m, uint32_t D, uint32_t C)
		.global		Zeller1
		.thumb_func
Zeller1:
            PUSH {R4,R5}

            LDR R4, =13
            MUL R4, R4, R1 //R4 = 13 * m
            SUB R4, R4, 1 //R4 = R4 - 1
            LDR R5, =5
            UDIV R4, R4, R5 //R4 = R4 / 5
            ADD R0, R0, R4 //R0 = k + R4
            ADD R0, R0, R2 //R0 = R0 + D
            LDR R4, =4
            UDIV R4, R2, R4 //R4 = D / 4
            ADD R0, R0, R4 //R0 = R0 + R4
            LDR R4, =4
            UDIV R4, R3, R4 //R4 = C / 4
            ADD R0, R0, R4 //R0 = R0 + R4
            LDR R4, =2
            MUL R4, R4, R3 //R4 = 2 * C
            SUB R0, R0, R4 //R0 = R0 + R4

            LDR R5, =7
            SDIV R4, R0, R5
            MULS R4, R4, R5
            SUB R0, R0, R4 //R0 = R0 % 7

            CMP R0, 0
            IT LT
            ADDLT R0, R0, 7 //if(R0 < 0): R0 = R0 + 7
            POP {R4,R5}
            BX LR


        //uint32_t Zeller2(uint32_t k, uint32_t m, uint32_t D, uint32_t C)
        //may not contain any divide instructions (SDIV or UDIV)
		.global		Zeller2
		.thumb_func
Zeller2:
            PUSH {R4,R5}

            LDR R4, =13
            MUL R4, R4, R1 //R4 = 13 * m
            SUB R4, R4, 1 //R4 = R4 - 1

            LDR R5,=858993459 //R5 = 2^32 / 5
	        SMMUL R4,R4,R5

            ADD R0, R0, R4 //R0 = k + R4
            ADD R0, R0, R2 //R0 = R0 + D
            
            LDR R4, =1073741824 //R4 = 2^32 / 4
            SMMUL R4, R2, R4

            ADD R0, R0, R4 //R0 = R0 + R4

            LDR R4, =1073741824 //R4 = 2^32 / 4
            SMMUL R4, R3, R4
            
            ADD R0, R0, R4 //R0 = R0 + R4
            LDR R4, =2
            MUL R4, R4, R3 //R4 = 2 * C
            SUB R0, R0, R4 //R0 = R0 + R4

            LDR R5,=613566756 //R5 = 2^32 / 7
	        SMMUL R4,R0,R5

            LDR R5, =7
            MULS R4, R4, R5
            SUB R0, R0, R4 //R0 = R0 % 7

            CMP R0, 0
            IT LT
            ADDLT R0, R0, 7 //if(R0 < 0): R0 = R0 + 7
            POP {R4,R5}
            BX LR


        //uint32_t Zeller3(uint32_t k, uint32_t m, uint32_t D, uint32_t C)
        //may not contain any multiply instructions (MUL, MLS, etc.)
		.global		Zeller3
		.thumb_func
Zeller3:
            PUSH {R4,R5}

            LSL R4, R1, 4 //2^4
            SUB R4,R4, R1, LSL 1 //16 - 2
            SUB R4,R4, R1 //R4 = R4 * 13

            SUB R4, R4, 1 //R4 = R4 - 1
            LDR R5, =5
            UDIV R4, R4, R5 //R4 = R4 / 5
            ADD R0, R0, R4 //R0 = k + R4
            ADD R0, R0, R2 //R0 = R0 + D
            LDR R4, =4
            UDIV R4, R2, R4 //R4 = D / 4
            ADD R0, R0, R4 //R0 = R0 + R4
            LDR R4, =4
            UDIV R4, R3, R4 //R4 = C / 4
            ADD R0, R0, R4 //R0 = R0 + R4

            LSL R4, R3, 1 //R4 = 2 * C

            SUB R0, R0, R4 //R0 = R0 + R4

            LDR R5, =7
            SDIV R4, R0, R5

            RSB R4, R4, R4, LSL 3 //R4 = R4 * 7

            SUB R0, R0, R4 //R0 = R0 % 7

            CMP R0, 0
            IT LT
            ADDLT R0, R0, 7 //if(R0 < 0): R0 = R0 + 7
            POP {R4,R5}
            BX LR


.end