function f=sfitness(u)
% SFITNESS slightly different fitness measure of clustering.
%
% F=FITNESS(U) returns the (SU) fitness of the clustering U.
% 
% See also FITNESS

[maxu, maxi] = max(u);
maxu = maxu(maxu>0);
base = 1/size(u,1);


if length(maxu) ~= 0
%     f =mean(log10(maxu).*maxu);
%    f =mean(log10(maxu));
%    f = log10(maxu)*maxu';
    
%    po = (maxu-base)/base;
    po = (maxu-base)/(1-base);
    f = mean( log10(po) );
else
    f = -Inf;
end





%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%



