function [b,bint,r,rint,stats]=regressAddOnes(y,xs)
%
%

[b,bint,r,rint,stats]=regress(y,[ones([size(xs,1) 1]) xs]);


