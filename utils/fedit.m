function fedit(varargin)
%
%

for fi=1:length(varargin)
  fn = varargin{fi};
  if ~strcmp('.m',fn(end-1:end))
    fns = fn;
    fn = [fn '.m'];
  else
    fns = fn(1:end-2);
  end
  if ~isempty(which(fn))
    warning('use edit instead, this file exists')
  else
    eval(sprintf('!echo function %s > %s', fns,fn));
    eval(sprintf('xedit %s',fn));
  end
end
