    .syntax unified
    .cpu cortex-m4
    .text

//Parameter Description
//nibbles Starting address where nibbles are stored in memory.
//which A nibble position (0 to 80) within the array of nibbles.
//value A four-bit number (0 to 9); 0 represents an empty cell.

//void PutNibble(void *nibbles, uint32_t which, uint32_t value);
    .global PutNibble
    .thumb_func
PutNibble:
    LSRS R1,R1,1            //R1 / 2, remainder in carry flag
    LDRB R3, [R0, R1]       //R3 = byte with desired nibble
    ITTE CS
        ANDCS R3,R3,0x0F    //Flag = 1: Clear most significant nibble
        LSLCS R2,R2,4           //Left shift
        ANDCC R3,R3,0xF0    //Flag = 0: Clear least significant nibble
    ORR R2, R2, R3
    STRB R2,[R0,R1]
    BX LR


//uint32_t GetNibble(void *nibbles, uint32_t which) ;
    .global GetNibble
    .thumb_func
GetNibble:
    LSRS R1,R1,1            //R1 / 2, remainder in carry flag
    LDRB R3,[R0,R1]         //R3 = byte with desired nibble
    ITE CS
        LSRCS R3, 4         //Flag = 1: Right Shift
        ANDCC R3,R3,0x0F    //Flag = 0: Clear most significant nibble 
    MOV R0,R3
    BX LR


.end