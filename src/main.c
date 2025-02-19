#include <ncurses.h>

int main() {
    char *buf = "hello\n";
    initscr();
    addstr(buf);
    refresh();

    getch();
    endwin();

    return 0;
}
