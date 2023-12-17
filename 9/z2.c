#include <stdio.h>
#include <stdlib.h>

//Na wyjściu: grad[i] = scale * sqrt( (data[i+1] - data[i-1])^2 + (data[i+N] - data[i-N])^2)
// dla i=0,1,...,N-2
extern void gradientSSE(float *grad, float * data, int N, float scale);

int main(int argc, char** argv) {
  if(argc != 3) {
    printf("usage: in.bmp out.bmp\n");
    return -1;
  }
  const int HL=1078;
  unsigned char header[HL];
  int i,j;
  FILE *strm = fopen(argv[1],"rb");
  fread(header, 1, HL, strm); // wczytuje header
                              
  unsigned int bitsPerPixel = ((unsigned int)header[28]) | ((unsigned int)header[29] << 8);
  unsigned int N = ((unsigned int)header[18]) | ((unsigned int)header[19] << 8);
  printf("%d\n", bitsPerPixel);
  N *= (bitsPerPixel/8);
  printf("%d\n", N);

  float* data = (float*)malloc(sizeof(float)*N*N);
  float* grad = (float*)malloc(sizeof(float)*N*N);
  for(i=0; i<N; i++)
    for(j=0; j<N; j++)
      data[i*N+j]=(float)fgetc(strm);  // czyta piksele i konwertuje na float
  fclose(strm);
  for(i=1; i<N-1; i++) // Dla wszystkich pikseli "wewnętrznych"
    gradientSSE(grad+1+i*N, data+i*N+1, N, 7);    // wyznaczamy gradient

  for(i=0; i<N; i++){ // Tworzymy białą ramkę obrazka
     grad[i]=255; grad[N*(N-1)+i]=255; grad[i*N]=255; grad[i*N+(N-1)]=255;
  }

  strm=fopen(argv[2],"wb");
  fwrite(header, 1, HL, strm);
  for(i=0; i<N; i++)
    for(j=0; j<N; j++)
      fputc((unsigned char)grad[i*N+j],strm);
  fclose(strm);
}
