#include <stdio.h>

int32_t Bits2Signed(int8_t bits[8]) ; // Convert array of bits to signed int.
uint32_t Bits2Unsigned(int8_t bits[8]) ; // Convert array of bits to unsigned int
void Increment(int8_t bits[8]) ; // Add 1 to value represented by bit pattern
void Unsigned2Bits(uint32_t n, int8_t bits[8]) ; // Opposite of Bits2Unsigned.

// Convert array of bits to signed int.
int32_t Bits2Signed(int8_t bits[8]) {
    uint32_t n = Bits2Unsigned(bits);
    if (n > 127)
        n -= 256;
    return n;
}

// Convert array of bits to unsigned int
uint32_t Bits2Unsigned(int8_t bits[8]) {
    int32_t n = 0;
    int i;
    for(i = 7; i >= 0; i--)
        n = 2 * n + bits[i];
    return n;
}

// Add 1 to value represented by bit pattern
void Increment(int8_t bits[8]) {
    int i;
    for(i = 0; i < 8; i++) {
        if(bits[i] == 0) {
            bits[i] = 1;
            break;
        }
        if(bits[i] == 1)
            bits[i] = 0;
    }
    return;
}

// Opposite of Bits2Unsigned.
void Unsigned2Bits(uint32_t n, int8_t bits[8]) {
    int a, i;
    for(i = 0; i < 8; i++) {
        a = n % 2;
        n = n / 2;
        bits[i] = a;
    }
    return;
}