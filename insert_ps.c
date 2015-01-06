#include <stdio.h>
#include <string.h>
#include <stdbool.h>

int main(int argc, char **argv){
    if (argc > 2 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))) {
            printf("Insert <p> and </p> tags around every paragraph. Give me a file name, or I'll use stdin. Always writes to stdout.");
            return 0;
    }
    FILE *in = (argc ==2) ? fopen(argv[1], "r") : stdin;
    FILE *out = stdout;

    char c;
    bool one_nl = false, multi_nl=false;
    while ((c=fgetc(in))!=EOF)
        if (c=='\n' && one_nl) multi_nl = true;
        else if (c=='\n' && !one_nl) one_nl = true;
        else {
            if (multi_nl) fprintf(out, "</p>\n\n<p>");
            else if (one_nl) fputc('\n', out);
            fputc(c, out);
            multi_nl=one_nl=false;
        }
    fputc('\n', out);
}
