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
    LSRS R1,R1,1         //R1 = index /2, remainder in carry flag
    LDRB R3, [R0, R1]    //R3 = byte with desired nibble
    ITTE CS
        ANDCS R3,R3,0x0F     //Clear most significant nibble if flag=1
        LSLCS R2,R2,4        //Move nibble data to most significant nibble
        ANDCC R3,R3,0xF0     //Clear least significant nibble if flag = 0
    ORR R2, R2, R3
    STRB R2,[R0,R1]cd
    BX LR


//uint32_t GetNibble(void *nibbles, uint32_t which) ;
    .global GetNibble
    .thumb_func
GetNibble:
    LSRS R1,R1,1    //index = index /2, remainder in carry flag
    LDRB R3,[R0,R1]
    ITE CS
        LSRCS R3, 4
        ANDCC R3,R3,0x0F
    MOV R0,R3
    BX LR


.end