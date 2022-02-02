#include <stdio.h>

int main(int argc, char **argv)
{
    int a = 1, b = 0;

    if (a == 1) goto foo;
    ++a;
    a *= 3;
    ++a;
    a *= 3;
    ++a;
    a *= 3;
    a *= 3;
    ++a;
    ++a;
    a *= 3;
    a *= 3;
    ++a;
    ++a;
    a *= 3;
    ++a;
    ++a;
    a *= 3;
    goto bar;
foo:
    a *= 3;
    a *= 3;
    ++a;
    ++a;
    a *= 3;
    ++a;
    ++a;
    a *= 3;
    ++a;
    a *= 3;
    ++a;
    a *= 3;
    ++a;
    a *= 3;
    ++a;
    ++a;
    a *= 3;
    ++a;
    ++a;
    a *= 3;
    a *= 3;
    ++a;
bar:
    if (a == 1) {
        printf("a=%d b=%d\n", a, b);
        return 0;
    }
    ++b;
    if ((a & 1) == 0)
        goto baz;
    a *= 3;
    ++a;
    goto bar;
baz:
    a >>= 1;
    goto bar;
}
