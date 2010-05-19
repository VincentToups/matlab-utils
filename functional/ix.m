function res = ix(ra,varargin)
% RES = IX(MATRIX,INDS1,INDS2,...,INDS3) indexes MATRIX with INDS
%  Identical to MATRIX(INDS1,INDS2,INDS3)
%  Does not support END notation

res = ra(varargin{:});
