#include <math.h>

static int smallestfactor(int n);

/* Given a number n, return the number of prime factors it has. */

int factors(int n)
{
	int numfactors = 0;

	while (n > 1)
	{
		n /= smallestfactor(n);
		numfactors++;
	}

	return numfactors;
}

static int smallestfactor(int n)
{
	int i, limit;

	limit = (int) sqrt(n) + 1;

	for (i = 2; i < limit; i++)
		if (n % i == 0)
			return i;

	return n;
}
