#include "dgemm.h"
#include <immintrin.h>
#include <inttypes.h>
#include <stdio.h>
#include <omp.h>


void dgemm(float *a, float *b, float *c, int n)
{
    __m256 va, vb, temp;

    int lim = n - (n % 8);
    #pragma omp parallel for 
    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            for(int k = 0; k < lim; k+=8) {

                va = _mm256_loadu_ps(&a[i*n+k]);

                vb = _mm256_loadu_ps(&b[j*n+k]);

                temp = _mm256_mul_ps(va,vb);
                temp = _mm256_hadd_ps(temp, _mm256_permute2f128_ps(temp,temp,1));
                temp = _mm256_hadd_ps(temp, temp);
                temp = _mm256_hadd_ps(temp, temp);
                c[i * n + j] = c[i * n + j] + temp[0];
                
                
            }
           

        }
        
    }

   for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            for (int k = lim; k < n; k++)
            {

                c[i * n + j] += a[i * n  + k] * b[j * n  + k];

            }
           
        }
        
    }
}



