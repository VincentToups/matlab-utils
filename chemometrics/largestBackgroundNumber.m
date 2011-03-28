function n = largestBackgroundNumber(directory)
%
%

files = ddirnames(directory);
if length(files) == 0
  n = 0;
else
  ns = map(@(fn) dsf(fn,[],'bgNumber',0),files);
  n = max(ns);
end
