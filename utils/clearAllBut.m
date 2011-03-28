function clearAllBut(varargin)
%

w = evalin('caller','who');
ds = setdiff(w,varargin);
for di=1:length(ds)
  d=ds{di};
  evalin('caller',sprintf('clear %s', d));
end
