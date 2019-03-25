#include "stdio.h"

int main()
{

	long n = 0, tmp = 0;
	long tab[1000000];
	long long maxpath = 0;
	long long longestpath = 0;

	scanf("%ld\n", &n);

	for (long i = 0; i < n; i++)
	{
		scanf("%ld\n", &tmp);
		tab[i] = tmp;
		maxpath += tmp;
	}

	long long path1 = 0, path2 = 0, i = 0, j = 1;
	// printf("maxpath %lld \n", maxpath);

	path1 = tab[0];
	while(j<=2 * n){
		if (path1 <= maxpath / 2){
			path1 += tab[j % n];
			path2 = maxpath - path1;
			j++;

			long long short_path = 0;
			if (path1 < path2)
			{
				short_path = path1;
			}
			else
			{
				short_path = path2;
			}
			if (longestpath < short_path)
				longestpath = short_path;
		}
		else{
			path1 -= tab[i % n];
			path2 = maxpath - path1;
			i++;

			long long short_path = 0;
			if (path1 < path2)
			{
				short_path = path1;
			}
			else
			{
				short_path = path2;
			}
			if (longestpath < short_path)
				longestpath = short_path;
		}
	}
	printf("%lld\n", longestpath);
}