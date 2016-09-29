#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>
#include "crc.h"
#include "crc.c"

// Store all computed CRC32 values here
crc_t *key;
// Store all random strings here
char **store;

// Generates a random string 8 characters long
// From http://stackoverflow.com/questions/440133/how-do-i-create-a-random-alpha-numeric-string-in-c
void gen_random(char dest[]) {
    char alphanum[] =
     "0123456789"
     "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
     "abcdefghijklmnopqrstuvwxyz";

     size_t length = 8;
     int i=0;

     while(length-- > 0) {
         size_t index = (double) rand()/RAND_MAX*(sizeof alphanum - 1);
         dest[i] = alphanum[index];
         i++;
     }
     dest[i] = '\0';

}

// Checks if there is a collision with previous recorded CRCs
// Returns index of collision if there is one
int collisionCheck(crc_t crc, int size, char curr[]) {
    int i;

    for(i=0; i<size; i++) {
        if((crc == key[i]) && (strcmp(curr, store[i]) != 0)) {
            return i;
        }
    }
    return 0;
}

int main(void) {
    int i;
    int collision = 0;
    char dest[9];
    time_t t;
    srand((unsigned) time(&t));

    // Place string and CRC array on heap because they require lots of memory
    store = malloc(80000 * sizeof(char *));
    for(i=0; i<80000; i++) {
        store[i] = (char *)malloc(9);
    }
    key = malloc(80000 * sizeof(crc_t));

    crc_t crc;

    clock_t begin = clock();


    for(i=0; i<80000; i++) {
        // Generate random string and store in array
        gen_random(dest);
        strcpy(store[i], dest);
        // Compute its CRC32 hash value and store in array
        crc = crc_init();
        crc = crc_update(crc, (unsigned char *)dest, strlen(dest));
        crc = crc_finalize(crc);
        key[i] = crc;

        // To track loop progress
        printf("%d\n", i);

        // No need to check for collision if there is only one entry in array
        if(i!=0)
            collision = collisionCheck(crc, i-1, dest);

        // Print out collision
        if(collision!=0) {
            printf("Found collision at i = %d\n", collision);
            printf("Colliding strings are %s and %s\n", dest, store[collision]);
            printf("Their CRCs are 0x%lx and 0x%lx\n", crc, key[collision]);
            break;
        }
    }

    clock_t end = clock();
    double time_spent = (double)(end-begin)/CLOCKS_PER_SEC;
    printf("Time taken for program to run is: %lf\n", time_spent);

    return 0;
}
