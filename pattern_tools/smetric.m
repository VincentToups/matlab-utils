function [mss]=smetric(sp,sigs)
% SMETRIC produces metric space for spike trains (SCHRIEBER METRIC)

sp = sp(:,:,1);

cnts = sum(sp>0,2);
nzii = find(cnts>0);
zii = find(cnts==0);

mss = cschrieber(sp,sigs);

for j=1:size(mss,1)
  mss(j,zii,zii) = 0;
  mss(j,:,:) = 1 - mss(j,:,:);
  s = squeeze(mss(j,:,:));
  mss(j,:,:) = s - eye(size(s,1));
end
