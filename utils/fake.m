function [spikes,bwr] = fake(m,s,r,nt)
% SPIKES=FAKE(M,S,R,NT) returns a set of NT fake trials with events
% given by the statistics given by M,S and R.  M,S, and R specify the
% means, standard deviations and reliabilites of the data respectively.
% 
% [SPIKES,BWR] = FAKE(.) returns the binary word representation in
% BWR


th = length(m);

st = randn( [nt th] );
s = st.*repmat( s, [nt 1] );

spikes = repmat(m, [nt 1]) + ( s );
rt = rand(size(spikes));
r = repmat(r, [nt 1]);
r = +(r >= rt );
spikes = spikes.*r;

lt = size(spikes,2);
for i=1:size(spikes,1)
    ss = spikes(i,:);
    ls = length(ss(ss>0));
    lt = length(ss);
    spikes(i,:) = [ss(ss>0) zeros([1 lt-ls])];
end

spikes = trimzeros(spikes);

