function o=filt(f,varargin)
% [R1,R2,...,RN] = FILT(F,MATRIX1,MATRIX2,...,MATRIXN) filters MATRIXES by F
%  R1,R2,...,RN are the values of MATRIX1 MATRIX2 ... MATRIXN where F is true.
%  These are generally returned as flat arrays unless F is always true.  Then
%  this is the identity.

varargin;
ii = find(map(f,varargin{:}));
o = map(@(item) item(ii),varargin);
% if ~isa(o,'cell')
%   varargout = {o};
% else
%   varargout = o;
% end
