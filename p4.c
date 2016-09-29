#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>
#include "crc.h"
#include "crc.c"

const size_t length = 7;

// Generates a random string 32 characters long
void gen_random(char dest[], size_t length) {
    char alphanum[] =
     "0123456789"
     "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
     "abcdefghijklmnopqrstuvwxyz";

     int i=0;

     while(length-- > 0) {
         size_t index = (double) rand()/RAND_MAX*(sizeof alphanum - 1);
         if(index == 62)
            index--;
         dest[i] = alphanum[index];
         i++;
     }
     dest[i] = '\0';


}

int main(void){
    char md5[33] = "632A783024D1A6552B597B9620314533";
    char dest[8]; 
    crc_t crc;
    crc_t md5_crc;
    time_t t;
    int i=0;
    srand((unsigned) time(&t));

    clock_t begin = clock();

    // Get CRC32 value of the MD5 hash
    crc = crc_init();
    crc = crc_update(crc, (unsigned char *)md5, strlen(md5));
    crc = crc_finalize(crc);
    md5_crc = crc;

    while(1) {
        gen_random(dest, length);

        printf("%d\n", i);

        crc = crc_init();
        crc = crc_update(crc, (unsigned char *)dest, strlen(dest));
        crc = crc_finalize(crc);

        // Check if computed CRC32 value matches the desired one
        if(crc == md5_crc){
            printf("Found collision at i = %d\n", i);
            printf("Colliding string is %s\n", dest);
            printf("Its CRC is 0x%lx\n", crc);
            break;
        }

        i++;
    }

    clock_t end = clock();
    double time_spent = (double)(end-begin)/CLOCKS_PER_SEC;
    printf("Time taken for program to run is: %lf\n", time_spent);
}
