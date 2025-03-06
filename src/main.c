#include <ncurses.h>

int main() {
    initscr();
    keypad(stdscr, TRUE);
    nonl();
    cbreak();
    echo();

    if (has_colors()) {
        start_color();
        init_pair(1, COLOR_RED, COLOR_BLACK);
        init_pair(2, COLOR_GREEN, COLOR_BLACK);
        init_pair(3, COLOR_BLUE, COLOR_BLACK);
        init_pair(4, COLOR_YELLOW, COLOR_BLACK);
        init_pair(5, COLOR_MAGENTA, COLOR_BLACK);
        init_pair(6, COLOR_CYAN, COLOR_BLACK);
        init_pair(7, COLOR_WHITE, COLOR_BLACK);
    }

    int num = 0;
    while (1) {
        getch();
        attrset(COLOR_PAIR(num & 8));
        num += 1;
    }

    endwin();

    return 0;
}
