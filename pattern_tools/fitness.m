function f=fitness(u)
% FITNESS rates the fitness of a clustering.
%
%  F=FITNESS(U) returns the (SU) fitness of the clustering U.
%  FITNESS essentially measures the average sureness of
%  a fuzzy clustering.  Fitness values are negative, but
%  larger fitness measures are better.
%

[maxu, maxi] = max(u);
maxu = maxu(maxu>0);
if length(maxu) ~= 0
%     f =mean(log10(maxu).*maxu);
%    f =mean(log10(maxu));
    f = log10(maxu)*maxu';
else
    f = -Inf;
end





%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%



