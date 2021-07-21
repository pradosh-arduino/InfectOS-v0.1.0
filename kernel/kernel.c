#include "include/kernelInit.h"

void* KrnlMain(uint32_t r0, uint32_t r1, uint32_t atags){
    uart_puts("This text is form Kernel!\n\r");

    while (1)
		uart_putc(uart_getc());
}