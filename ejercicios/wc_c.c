#include <stdio.h>
#include <ctype.h>

int main(void) {
    int c;
    long chars = 0, words = 0, lines = 0;
    int inword = 0;

    while ((c = getchar()) != EOF) {
        chars++;
        if (c == '\n') lines++;

        if (isalpha((unsigned char)c)) {
            if (!inword) { words++; inword = 1; }
        } else {
            inword = 0;
        }
    }

    printf("%8ld%8ld%8ld\n", lines, words, chars);
    return 0;
}
