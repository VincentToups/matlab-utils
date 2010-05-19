function r=relischr(spikes,sig)

if ~exist('sig')
  sig = 3;
end

ms = squeeze(cschrieber(spikes,sig));
ii = triu(~eye(size(ms,1)));
dists = ms(ii);
r = sqrt(mean(dists));
