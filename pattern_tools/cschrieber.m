function ms2 = cschrieber(spikes,sigmas,k)
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

ntrials=size(spikes,1);
dum=sum(spikes,2);
iig=find(dum>0);
spikes=spikes(iig,:);

ss = spikes(:,:,1);
counts = sum(ss>0,2);
sigmas = sigmas(:);
ms = cschrieber_c(ss',sigmas,counts);
%size(ms)
%not necessary..you should not use these elements anyway
ii = find(eye(size(ms,2)));
reshape(ms,[size(ms,1) size(ms,2)*size(ms,3)]);
ms(:,ii) = 1;

if 0
    ms = reshape(ms,[1 size(ms)]);
end

ms(isnan(ms)) = 0;
ms = 1-ms;



%Add back the zeros for empty elements
ms2=zeros(length(sigmas),ntrials,ntrials); 
ms2(:,iig,iig)=ms;

return


