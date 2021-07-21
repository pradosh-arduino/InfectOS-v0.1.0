//######################################
//KERNEL INIT HEADER
//######################################
#include <stddef.h>
#include <stdint.h>

static inline void delay(int32_t count);
unsigned char uart_getc();
// SCREEN
void uart_init(int raspi);
void uart_putc(unsigned char c);
void uart_puts(const char* str);