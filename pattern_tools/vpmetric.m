function ms = vpmetric(spikes, q, k)
% MS = VPMETRIC(SPIKES,Q,K) returns the metric space for spikes
% for every value combination of values Q,K.  MS is returned as 
% a 4D array in which, for ms(i,j,r,s), i indexes the k values, j
% the q values, r the first spike train, s the second.

sz = size(spikes);
if length(sz) < 3 | sz(3) == 1
    spikes(:,:,2) = 0;
end

q = q(:);
k = k(:);

lens = sum( +(spikes(:,:,1)~=0), 2 );

psub = ones([sz(1) 1]);

for jj=unique(spikes(:,:,2))'
    t = +(spikes(:,:,2)==jj);
    t = sum(t,2) + 1;
    psub = psub.*t;
end

nsub = length(unique(spikes(:,:,2)));


ms = vpmetric_c(spikes,q,k,lens,nsub,psub);

    

