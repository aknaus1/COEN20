// Andrew Knaus
// April 15, 2020
// functions.s

            .syntax		unified
            .cpu		cortex-m4
            .text

            //int32_t Add(int32_t a, int32_t b)
            .global Add
            .thumb_func
Add:
            ADD   R0, R0, R1 //Adds Parameter 1 (R0) and Parameter 2 (R1) to R0
            BX    LR //Return

            //int32_t Less1(int32_t a)
            .global Less1
            .thumb_func
Less1:
            SUB   R0, 1 //Subtracts 1 from parameter 1 (R0)
            BX    LR //Return

            //int32_t Square2x(int32_t x)
            .global Square2x
            .thumb_func
Square2x:
            ADD   R0, R0, R0 //Adds Parameter 1 (R0) with itself and assigns result to R0
            B    Square //Return Square() function with R0

            //int32_t Last(int32_t x)
            .global Last
            .thumb_func
Last:
            PUSH  {R4, LR} //Saves previous data on R4 to stack
            MOV   R4, R0 //Copies parameter 1 (R0) to R4
            BL    SquareRoot //Calls function SquareRoot
            ADD   R0, R0, R4 //Adds SquareRoot result with original value
            POP   {R4, PC} //Return original value of R4

.end