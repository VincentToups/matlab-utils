/* cfcm2.h, faster fuzzy clustering */

void cfcm2(  const double * data, double * u, double * c, double * obj,
            int nv, int nd, int nc, double f, double conv, int max_it );
/** int cfcm2(  contst double * data, double * u, double *c, double * obj,
                int nv, int nd, int nc, double f, double conv, int max_it );
                
    Fills the 3 double pointer arrays u, c, obj, with the values in accordance
    with a fuzzy c-means clustering of the data passed in in data, with the
    the parameters nv, the number of vectors, nd, the number of dimensions of
    each vector, nc, the number of cluster centers, f, the 'fuzziness factor',
    conv, the minimum change in the obj function considered convergent, and
    max_it, the maximum number of iterations to attempt before stopping.
        This function expects that data, u, c, and obj all point to allocated
    1D memory locations of the proper size.  It indexes them using the same
    convention as matlab, that is to move up one in any dimension, you mave
    forward by the product of the sizes of the previous dimensions. */

