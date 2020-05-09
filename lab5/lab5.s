		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		MatrixMultiply
		.thumb_func
        //void MatrixMultiply(int32_t A[3][3], int32_t B[3][3], int32_t C[3][3])
    MatrixMultiply:
		PUSH	{R3-R11,LR}
		MOV		R3,0 //row = 0
		row_loop:
			CMP		R3,2 //row < 2
			BGT 	end_row
			MOV 	R4,0 //col = 0
			col_loop:
				CMP 	R4,2 //col < 2
				BGT		end_col
				MOV 	R5,0 //k = 0
				//address of A[row][column] = row * (#collumns) + collumn
				LDR		R11,=3 //#columns
				MUL 	R7,R3,R11 //row * column
				ADD		R7,R7,R4 //add collumn index
								
				LDR		R6,=0 //store 0
				STR 	R6,[R0,R7,lsl 2] //set A[row][collumn] to 0
				k_loop:
					CMP		R5,2 //k < 3
					BGT 	end_k
					MOV		R6,R0 //copy r0
					MOV		R9,R1 //copy r1
					MOV		R8,R2 //copy r2

					LDR		R0,[R0,R7, lsl 2] //r0 = A[row][column]

					MUL		R7,R3,R11 //row * #columns
					ADD		R7,R7,R5 //add column index
					LDR		R1,[R1,R7, lsl 2]
					
					MUL 	R7,R5,R11 //k * #column
					ADD		R7,R7,R4 //add column index
					LDR 	R2,[R2,R7, lsl 2]

					BL		MultAndAdd//run multandadd

					MUL 	R7,R3,R11 //multiply  row and numcolumn together
					ADD		R7, R7, R4 //add collumn index to address
					
					MOV		R10,R0 //save function return
					MOV		R0,R6 //move R0 back
					MOV		R1,R9 //move R1 back
					MOV		R2,R8 //move R2 back

					STR 	R10,[R0,R7, lsl 2]//copy result of mult and add to A

					ADD 	R5,R5,1 //k++
					B 		k_loop
				end_k:
				ADD 	R4,R4,1 //col++
				B		col_loop
			end_col:
			ADD 	R3, R3, 1 //row++
			B		row_loop
		end_row:
		POP		{R3-R11,PC}
		.end
