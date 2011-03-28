function nms=ddirnames(directory,postF)

if ~exist('postF','var')
  postF = @(x) 1==1;
end

nms = map(@(x) x.name, ddir(directory));
nms = nms(3:end);
nms = filt(postF,nms);
