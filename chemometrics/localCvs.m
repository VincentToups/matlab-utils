function cvs=localCvs(data,varargin)
%
%

defaults.stepSize = 20;
defaults.keepThresh = 1;
defaults.maxReturn = 4;

handle_defaults;

if ~exist('stepSize','var')
  stepSize = 20;
end

nTrial = size(data,2);
nCvs = floor((nTrial/stepSize))-1;
cvs = [];
for i=1:nCvs
  bgInds = (1:stepSize) + (i-1)*stepSize;
  inds = (1:stepSize) + i*stepSize;
  bg = mean(data(:,bgInds),2);
  fg = mean(data(:,inds),2);
  cv = fg-bg;
  if max(abs(cv))>keepThresh
    cvs = [cvs cv];
  end
end
if ~isempty(cvs)
  maxes = max(abs(cvs),[],1);
  [vv,ii] = sort(maxes,'descend');
  cvs = cvs(:,1:min([size(cvs,2) maxReturn]));
end

