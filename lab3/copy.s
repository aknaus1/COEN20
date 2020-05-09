// Andrew Knaus
// April 22, 2020
// copy.s

            .syntax		unified
            .cpu		cortex-m4
            .text

//Copy 1 byte at a time using LDRB and STRB, and optimize the execution time by
//updating the address using the Post-Indexed addressing mode shown in Table 4-6.
            .global UseLDRB
            .thumb_func
UseLDRB:
            .rept 512           // 512 / 1 = 512
                LDRB R2, [R1],1     //Read content of souce and increment by 1 byte.
                STRB R2, [R0],1     //Store conntent and increment by 1 byte.
            .endr               //End loop
            BX LR               //return

//Copy 2 bytes at a time using LDRH and STRH, and optimize the execution time by
//updating the address using the Post-Indexed addressing mode shown in Table 4-6.
            .global UseLDRH
            .thumb_func
UseLDRH:
            .rept 256               // 512 / 2 = 256
                LDRH R2, [R1],2         //Read content of souce and increment by 2 bytes.
                STRH R2, [R0],2         //Store content and increment by 2 bytes.
            .endr                   //end loop
            BX LR                   //return

//Copy 4 bytes at a time using LDR and STR, and optimize the execution time by
//updating the address using the Post-Indexed addressing mode shown in Table 4-6.
            .global UseLDR
            .thumb_func
UseLDR:
            .rept 128               // 512 / 4 = 128
                LDR R2, [R1],4          //Read content of souce and increment by 4 bytes.
                STR R2, [R0],4          //Store content and increment by 4 bytes.
            .endr                   //end loop
            BX LR                   //return

//Copy 8 bytes at a time using LDRD and STRD, and optimize the execution time by
//updating the address using the Post-Indexed addressing mode shown in Table 4-6.
            .global UseLDRD
            .thumb_func
UseLDRD:
            .rept 64                // 512 / 8 = 64
                LDRD R2,R3, [R1],8      //Read content of souce and increment by 8 bytes.
                STRD R2,R3, [R0],8      //Store content and increment by 8 bytes.
            .endr                   //end loop
            BX LR                   //return

//Copy 32 bytes at a time using LDMIA and STMIA, and
//optimize the execution time by updating the addres
            .global UseLDM
            .thumb_func
UseLDM:
            push {R4-R9}           //Stores register value in stack
            .rept 16                // 512 / 32 = 16
                LDMIA R1!, {R2-R9}     //Read content of souce and increment by 16 bytes.
                STMIA R0!, {R2-R9}     //Store content and increment by 16 bytes.
            .endr                   //end loop
            pop {R4-R9}            //Puts original values stored in stack back into registers
            BX LR                   //return
.end