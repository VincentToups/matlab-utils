function spikes = fake(m,s,r,nt)
% FAKE produces surrogate data from a simple description.
%
% SPIKES=FAKE(M,S,R,NT) returns a set of NT fake trials with events
% given by the statistics given by M,S and R.  M,S, and R specify the
% means, standard deviations and reliabilites of the data respectively.
%
% See also MTFAKE
%

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
    sssz = ss(ss>0);
    spikes(i,1:length(sssz)) = sssz;
end

spikes = trimzeros(spikes);

