#include<stdio.h>

int main() {
    int zero = 0;

    int five = 123;
    while ((five & 456) != 72);

    int one = 0;
    five = 0;
    int four = (five & 65536);  // x0001 0000
    five = 3935295;
    int two = (four & 255);     // x0000 00ff
    five = five + two;
    five = (five & 16777215);   // x00ff ffff
    five = five * 65899;        // x0001 016b
    five = (five & 16777215);   // x00ff ffff

    if (256 > four) {           // x0000 0100
        two = 1;
    }
    else {
        two= 0;
    }
    printf("two: %d\n", two);

    int c;

    int a; // register 2
    int b; // register 3

    loop() {

        b = a + 1;
        b = b * 256;

        if (b > c) {

        }
        else {

        }


    }


}


/*

addi 2 1 3          # 18: loop starts
muli 3 256 3
gtrr 3 4 3
addr 3 1 1
addi 1 1 1
seti 25 0 1         
addi 2 1 2
seti 17 7 1         # 25: loop ends

*/

// 65536    0000 0000 0000 0001 0000 0000 0000 0000
// 256      0000 0000 0000 0000 0000 0001 0000 0000
// 