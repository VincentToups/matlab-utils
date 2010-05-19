function [results] = gapfcm(vectors,ncs,fcm_options)
%

if ~exist('fcm_options')
  fcm_options = [NaN NaN NaN 0];
end

for ni=1:length(ncs)
  ni
  nc=ncs(ni);
  [results.cs{ni}, results.us{ni}, ps]=myfcm(vectors, nc, fcm_options)
  results.ps(ni) = ps(end);
  [results.ncs{ni}, results.nus{ni}, nps]=myfcm(generate_gap_reference(vectors), nc, fcm_options)
  results.nps(ni) = nps(end);
  results.objgap(ni) = ps(end) - nps(end);
end

