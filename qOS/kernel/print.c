#include <qos/kernel/print.h>

#define VGA_MEMORY 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

static volatile unsigned short *const vga =
    (volatile unsigned short *)VGA_MEMORY;

static unsigned int cursor_x = 0;
static unsigned int cursor_y = 0;

void print(const char *str)
{
      while (*str)
      {
            if (*str == '\n')
            {
                  cursor_x = 0;
                  cursor_y++;
            }
            else
            {
                  vga[cursor_y * VGA_WIDTH + cursor_x] =
                      (0x0F << 8) | *str;

                  cursor_x++;

                  if (cursor_x >= VGA_WIDTH)
                  {
                        cursor_x = 0;
                        cursor_y++;
                  }
            }

            if (cursor_y >= VGA_HEIGHT)
            {
                  cursor_y = 0;
            }

            str++;
      }
}

void clear(void)
{
      for (unsigned int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++)
      {
            vga[i] = (0x0F << 8) | ' ';
      }

      cursor_x = 0;
      cursor_y = 0;
}