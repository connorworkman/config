#include <stdio.h>

int main(int argc, char **argv)
{
	//char  hello[20] = "hello";
	//hello[3] = 0;
	int (*foobar)(const char *,...) = printf;
	int i, var = 2, *pvar, *pvar2 = &var;
	pvar = &var;
	printf ("%d %p %d\n", var, pvar, *pvar2);
	foobar("%s", "Hello World\n");
	for (i = 0; i < argc; i++)
		foobar("%s\n", argv[i]);
	printf("%s","Hello World\n");
	//printf("%s",hello);
	return 0;
}
