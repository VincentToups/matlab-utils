#include "mex.h"
#include "cfcm2.h"

#define DATA 	prhs[0]
#define	NC	prhs[1]
#define OPTIONS	prhs[2]

#define CENTER 	plhs[0]
#define U	plhs[1]
#define OBJ_FCN	plhs[2]

void mexFunction(	int nlhs,	mxArray * plhs[],
			int nrhs, const	mxArray * prhs[] )
{
    mxArray * centers;
    mxArray * u;
    mxArray * obj;
    
	int * dims;
	double * optr;
	
	int nd;
	int max_it;
	int i;
	int j;
	
	double f;
	double conv;

	if( nrhs < 2 ){
		mexErrMsgTxt("MYFCM requires at least 2 arguments.");
		return;
	}
	if( nrhs == 2){
		/*Use default options*/
		max_it = 100;
		f = 2;
		conv = 1e-5;
	}
	else{
		/*use the options passed in*/
		optr = (double*)mxGetPr(OPTIONS);
		max_it = (int) optr[1];
		f = optr[0];
		conv = optr[2];
		if( optr[3] == 1 ){
			mexWarnMsgTxt("MYFCM lacks a verbose mode at the moment...");
		}
	}

	if( nrhs > 3 ){
		mexErrMsgTxt("MYFCM takes no more than 3 arguments.");
		return;
	}
	
	
	nd = mxGetNumberOfDimensions( DATA );
	if( nd > 2 ){
		mexErrMsgTxt("DATA matrix must be 2D.");
	}

	
	dims = (int*)mxGetDimensions(DATA);
	
	optr = mxGetPr(NC);
	
	centers = mxCreateDoubleMatrix( optr[0], dims[1], mxREAL );
	u = mxCreateDoubleMatrix( optr[0], dims[0], mxREAL );
	obj = mxCreateDoubleMatrix( 1, max_it, mxREAL );
	
	cfcm2( mxGetPr(DATA), mxGetPr(u), mxGetPr(centers), mxGetPr(obj), 
            dims[0], dims[1], optr[0], f, conv, max_it );
	
	switch (nlhs){
		case 3:
			CENTER = centers;
		case 2:
            U = u;
		case 1:
			OBJ_FCN = obj;
	}
	return;
}
	
