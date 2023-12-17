#include <stdio.h>
const int N = 100;

// na wyjściu out[i] = wiersz[i+1] - wiersz[i]
extern void diff(char *out,char *wiersz, int n);

void diff2(char* out, char* wiersz, int n) {
    for(int i=1; i<N; i++) {
        out[i-1] = wiersz[i]-wiersz[i-1];
    }
}

int main(void)
{
    char tablica[N+1], DIFF[N], DIFF2[N];
    int i;

    tablica[0]=1;

    for(i=1;i<=N;i++) {
        tablica[i]=tablica[i-1]+i;
    }

    for(i=0;i<N;i++) 
        printf("%d ",tablica[i]);
    printf("\n");

    diff(DIFF, tablica, N);
    diff2(DIFF2, tablica, N);

    for(i=0;i<N;i++)
        printf("%u ",DIFF[i]);

    printf("\n");

    for(i=0;i<N;i++)
        printf("%u ",DIFF2[i]);

    printf("\n");
}
