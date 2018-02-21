#include <stdio.h>
#include <inttypes.h>


uint32_t setbit(num, n)
{
    uint32_t  newNum;

    /* Left shift 1, n times and perform bitwise OR with num */
    newNum = (1 << n) | num;

    return n;
}

uint32_t  clearbit(num, n)
{
    uint32_t  newNum;

    /* Left shift 1, n times and perform bitwise OR with num */
    newNum =  num & ~(1 << n);

    return n;
}

uint32_t  main(){

    uint32_t  num, n, newNum;

    printf("Enter any number: ");
    scanf("%d", &num);

    printf("Enter nth bit to set (0-31): ");
    scanf("%d", &n);

    newNum = clearbit(num, n);

    printf("Number before setting %d bit: %d (in decimal)\n", n, num);
    printf("Number after setting %d bit: %d (in decimal)\n", n, newNum);

    return 0;
}