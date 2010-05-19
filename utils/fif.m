function r=fif(co,lat,laf)
%
%
if ~exist('laf')
  laf = @() 0;
end

if co
  r = lat();
else
  r = laf();
end
