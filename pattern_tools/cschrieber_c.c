/* This file produced from cschrieber.c.lpp by luacpp */
/* which is copy right 2006 J.V. Toups */
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<mex.h>

#define pi (3.14159265358979)
#define e  (2.71828182845905)

#define COEF (1.25331413731550)

#define SPIKES			 prhs[0]
#define SIGMAS			 prhs[1]
#define COUNTS			 prhs[2]
#define MS			 plhs[0]

double analytic_dot(double * train1, double * train2, long len1, long len2, double sigma);
/* LEN1 and LEN2 are the maximum lengths of the trains, the trains themselves can
 * have terminating zeros and the function will behave properly.  The lengths are
 * just for those cases where there are as many spikes as elements in the arrays so
 * we can prevent buffer overruns. */


void mexFunction( int nlhs,         mxArray * plhs[],
                  int nrhs,         const mxArray * prhs[] ){
    
    int i,j,k,joff,koff;
    
    int output_size[3];
    double * ms;
    double * norms;
    double * tmp;
    long c;
    
    if(nrhs!=3){
        mexErrMsgTxt("mlmapmod_c requires 3 arguments");
    }
    if(nlhs!=1){
        mexErrMsgTxt("mlmapmod_c requires 1 output arguments");
    }
    double * spikes;
    const int * sz_spikes;
    int nd_spikes;
    double * sigmas;
    const int * sz_sigmas;
    int nd_sigmas;
    double * counts;
    const int * sz_counts;
    int nd_counts;
    nd_spikes = mxGetNumberOfDimensions(SPIKES);
    sz_spikes = mxGetDimensions(SPIKES);
    spikes = mxGetPr(SPIKES);
    nd_sigmas = mxGetNumberOfDimensions(SIGMAS);
    sz_sigmas = mxGetDimensions(SIGMAS);
    sigmas = mxGetPr(SIGMAS);
    nd_counts = mxGetNumberOfDimensions(COUNTS);
    sz_counts = mxGetDimensions(COUNTS);
    counts = mxGetPr(COUNTS);

    output_size[0] = sz_sigmas[0];
    output_size[1] = output_size[2] = sz_spikes[1];
    MS = mxCreateNumericArray(3,output_size, mxDOUBLE_CLASS, mxREAL );
    ms = mxGetPr(MS);

    norms = malloc(sizeof(double)*sz_spikes[1]);
    
    /*mexPrintf("Size sigmas = %d\n", sz_sigmas[0]);*/
    
    joff = sz_sigmas[0];
    koff = sz_sigmas[0]*sz_spikes[1];

    for(i=0;i<sz_sigmas[0];i++){
        for(j=0;j<sz_spikes[1];j++){
            tmp = spikes+(long)sz_spikes[0]*j;
            c = (long)counts[j];
            norms[j] = analytic_dot(tmp,tmp,c,c,sigmas[i]);
        }
        for(j=0;j<sz_spikes[1];j++){
            for(k=j+1;k<sz_spikes[1];k++){
                ms[i + joff*k + koff*j] = ms[i + joff*j + koff*k] = 1-analytic_dot( spikes+(long)sz_spikes[0]*j, spikes+(long)sz_spikes[0]*k, (long)counts[j], (long)counts[k], sigmas[i])/(sqrt(norms[j])*sqrt(norms[k]));
            }
        }
    }
    free(norms);
    
}

double analytic_dot( double * train1 , double * train2, long len1, long len2, double sigma){
    int i = 0;
    int j = 0;
    double t1, t2, temp;
    double total = 0;
    double asigma = 0;
    
    if (sigma<0){
      asigma = -sigma;
    }
    else{
      asigma = sigma;
    }
    
    if( len1==0 || len2==0 ){
        return 0.0f;
    }

    /* mexPrintf("sigma is %f, asigma is %f\n",sigma, asigma); */
    while(i<len1 && train1[i] != 0){
        j = 0;
        while(j<len2 && train2[j] != 0){
            t1 = train1[i];
            t2 = train2[j];
            temp = t1-t2;
            if(sigma<0 || abs(temp)<4*asigma){
                /*mexPrintf("Comparing t1 = %f and t2 = %f\n\t and the result is %f\n", t1, t2, exp(-(temp*temp)/(4*asigma*asigma)) );*/
                total = total + exp(-(temp*temp)/(4*asigma*asigma));
            }
            j = j + 1;
        }
        i = i + 1;
    }
    /*mexPrintf("\tTotal is %f and norm is %f\n",total,norm);*/

    return total;
}
