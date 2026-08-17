#include <qos/kernel/print.h>
#include <qos/kernel/terminal.h>

void kernel_main(void) {
    clear();

    print("qOS> ");

    terminal_show_cursor();
    terminal_set_cursor(5, 0);

    for (;;) {
        __asm__ volatile ("hlt");
    }
}
