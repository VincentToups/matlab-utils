function f = compose(f1,f2,varargin)
if length(varargin)==0
  if ~exist('f2')
  f = f1;
  return
  end
  f = @(varargin) f1(f2(varargin{:}))
else
  fs = [{f1} {f2} varargin(:)'];

  fs = fliplr(fs);
  f1 = fs{1};
  frest = fs(2:end);
  f = foldl(@compose, f1, frest);
end
