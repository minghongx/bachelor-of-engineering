/*----------------------------------------------------------------------------
 * Name:    main.c
 * Purpose: wrapper for asm code
 *----------------------------------------------------------------------------*/
 
#include <MKL46Z4.h>

// declare external assembly language function (in a *.s file)
extern int exp26_asm(int value, int val2);

int main (void) {
	int	i, j, k, x;
	j = 0;
	k = 1;
	for(i=0;i<15;i++) {
		x = exp26_asm(j,k);  // Call the subroutine with j and k and return the value int x
		j = k;
		k = x;
	}
	return(j);
}
