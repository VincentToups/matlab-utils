/* my fcm v2 */
#include<stdlib.h>
#include<stdio.h>
#include<math.h>
#include "cfcm2.h"

void cfcm2(  const double * data, double * u, double * c, double * obj,
            int nv, int nd, int nc, double f, double conv, int max_it ){        
    int ii; /* misc index */
    int i; /* cluster index */
    int j; /* dimension index */
    int k; /* vector index */
    
    int it; /*iteration counter */
    
    double * unorms; /*norms for u, helps us avoid a loop over k*/
    double * dist; /* nc by nv matrix of distances to the cluster centers */
    double vnorm;
    double vsum;
    double impr;
    double tobj;
    
    register double reg1;
    register int    reg2;
    register double reg3;
    
    /* we assume someone else has done us the kindness of allocating 
     the u, c, obj matrices */
    
    /* allocate the matrix to contain the norms for u,
       during the calculation, we will store the norms seperately, and only 
       normalize after conversion/termination */
       
    unorms = malloc( sizeof(double)*nv );
    for(k=0;k<nv;k++){
        unorms[k] = 0.0f;
    }
    
    /* allocate the matrix to contain the distances */
    dist = malloc( sizeof(double)*nc*nv );
    for(ii=0; ii<nc*nv;  ii++){
        dist[ii]=0.0f;
    }
    
    /*seed the random number generator*/
    srand((unsigned)time(NULL));
    
    /* initialize u matrix with random values, calculate norms.  Use matlab
       indexing style */
    
    reg1 = 1.0f/(RAND_MAX - 1.0f);
    for(k=0; k<nv; k++){
        for(i=0; i<nc; i++){
            unorms[k] += (u[i+k*nc] = ((double)rand())*reg1);
        }
    }
    
    
    impr = conv + 10.0f;
    it = 0;
    if( f != 2.0f ){
        while( impr > conv && it < max_it ){
            
            /* first calculate the new centers.  do this for each cluster for each
                component */
     
            for(k=0;k<nv;k++){
		    reg1 = unorms[k];
                for(i=0;i<nc;i++){
                    u[i+k*nc] = pow( u[i+k*nc]/reg1, f );
                }
            }
            for(i=0; i<nc; i++){
                for(j=0; j<nd; j++){
                    vnorm = 0.0f;
                    vsum = 0.0f;
			reg2 = j*nv;
                    for(k=0;k<nv;k++){
			    reg1 = u[i+k*nc];
                        vnorm = vnorm + reg1;
                        vsum =  vsum + reg1*data[k+reg2];
                    }
                    reg3 = c[i+j*nc] = vsum/vnorm;
                        /* we have the jth component of the ith center, 
                        so we can calculate part of the sum squared distances 
                        to this center */
                    for(k=0;k<nv;k++){
                        /* dist will be the squared distance */
			    reg1 = reg3-data[k+reg2];
                        dist[i+k*nc] += reg1*reg1;
                    }                    
                }        
            }
            
            
            /* we need another for loop to calculate the obj function and the new u
                matrix and its normalizations */
            
            tobj = 0.0f;
		    reg1 = -1.0f/(f-1.0f);
            for(k=0; k<nv; k++){
                unorms[k] = 0.0f;
		        reg2 = k*nc;
                for(i=0;i<nc;i++){      
                    tobj = tobj +  u[i+reg2]*dist[i+reg2];
                    /* find the new u */
                    unorms[k] += (u[i+reg2] = pow( dist[i+reg2], reg1 ));
                    /*reset dist*/
                    dist[i+reg2] = 0.0f;
                }
            }
            
            obj[it] = tobj;
            if( it > 0 ){
                impr = fabs( tobj - obj[it-1] );
                }
            it++;
        }
        
        for(k=0;k<nv;k++){
		reg2 = k*nc;
		reg3 = unorms[k];
            for(i=0;i<nc;i++){
                u[i+reg2] = u[i+reg2]/reg3;
            }
        }
    }
    else{
        while( impr > conv && it < max_it ){
            
            /* first calculate the new centers.  do this for each cluster for each
                component */
     
            for(k=0;k<nv;k++){
		    reg1 = unorms[k];
                for(i=0;i<nc;i++){
                    reg3 = u[i+k*nc]/reg1;
                    u[i+k*nc] = reg3*reg3;
                }
            }
            for(i=0; i<nc; i++){
                for(j=0; j<nd; j++){
                    vnorm = 0.0f;
                    vsum = 0.0f;
			reg2 = j*nv;
                    for(k=0;k<nv;k++){
			    reg1 = u[i+k*nc];
                        vnorm = vnorm + reg1;
                        vsum =  vsum + reg1*data[k+reg2];
                    }
                    reg3 = c[i+j*nc] = vsum/vnorm;
                        /* we have the jth component of the ith center, 
                        so we can calculate part of the sum squared distances 
                        to this center */
                    for(k=0;k<nv;k++){
                        /* dist will be the squared distance */
			    reg1 = reg3-data[k+reg2];
                        dist[i+k*nc] += reg1*reg1;
                    }                    
                }        
            }
            
            
            /* we need another for loop to calculate the obj function and the new u
                matrix and its normalizations */
            
            tobj = 0.0f;
            for(k=0; k<nv; k++){
                unorms[k] = 0.0f;
		    reg2 = k*nc;
                for(i=0;i<nc;i++){      
                    tobj = tobj +  u[i+reg2]*dist[i+reg2];
                    /* find the new u */
                    unorms[k] += (u[i+reg2] = 1/dist[i+reg2] );
                    /*reset dist*/
                    dist[i+reg2] = 0.0f;
                }
            }
            
            obj[it] = tobj;
            if( it > 0 ){
                impr = fabs( tobj - obj[it-1] );
                }
            it++;
        }
        
        for(k=0;k<nv;k++){
		reg2 = k*nc;
		reg3 = unorms[k];
            for(i=0;i<nc;i++){
                u[i+reg2] = u[i+reg2]/reg3;
            }
        }
    }
    free(unorms);
    free(dist);
}
