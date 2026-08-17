#include <qos/kernel/terminal.h>

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

#define VGA_INDEX 0x3D4
#define VGA_DATA 0x3D5

static inline void outb(unsigned short port, unsigned char value)
{
      __asm__ volatile(
          "outb %0, %1"
          :
          : "a"(value), "Nd"(port));
}

void terminal_show_cursor(void)
{
      outb(VGA_INDEX, 0x0A);
      outb(VGA_DATA, 0x0E);

      outb(VGA_INDEX, 0x0B);
      outb(VGA_DATA, 0x0F);
}

void terminal_hide_cursor(void)
{
      outb(VGA_INDEX, 0x0A);
      outb(VGA_DATA, 0x20);
}

void terminal_set_cursor(unsigned int x, unsigned int y)
{
      if (x >= VGA_WIDTH)
            x = VGA_WIDTH - 1;

      if (y >= VGA_HEIGHT)
            y = VGA_HEIGHT - 1;

      unsigned short position = y * VGA_WIDTH + x;

      outb(VGA_INDEX, 0x0F);
      outb(VGA_DATA, position & 0xFF);

      outb(VGA_INDEX, 0x0E);
      outb(VGA_DATA, (position >> 8) & 0xFF);
}