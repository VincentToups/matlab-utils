function [hs]=spiralgram(spikes,freq,varargin)
%
%

[i,j,v] = find(spikes);

p = 1/freq;
v = v(:)';
phases = mod(v,p)*(1/p)*2*pi;
i = complex(0,1);
vectors = v.*exp(i*phases);
hs = plot(vectors,'.',varargin{:});



