function ms = cschrieber(spikes,sigmas,k)
% CSCHRIEBER Returns the Schrieber metric for SPIKES at all SIGMAS
%
%  CSCHRIEBER(SPIKES,SIGMAS) returns a 1xlength(SIGMAS)xsize(SPIKES,1)xsize(SPIKES,1)
%   array containing values of the metric.
%   The first dimension signifies nothing but is there for compatability with other measures
%   which can return values based on sensitivity to spike label.
%   the second index corresponds to the sigma value
%   the third and forth indexes are spike train indices.
%   The metric is normalized and subtrated from one to make it a dissimilarity
%    rather than a similarity
%
%   SEE ALSO: vpmetric
%
%   PS - This function calls the c code in cschrieber_c.mexglx

ss = spikes(:,:,1);
counts = sum(ss>0,2);
sigmas = sigmas(:);

ms = cschrieber_c(ss',sigmas,counts);

ii = find(eye(size(ms,1)));
ms(ii) = 0;

ms = reshape(ms,[1 size(ms)]);
ms(isnan(ms)) = 0;
ms = 1-ms;

