function hs=nrast(spikes,varargin)
%
%

if ~isheld
  cla;
end

[i,j,v] = find(spikes);
xs = [v(:)';v(:)'];
ys = [i(:)'+.2;i(:)'+(1-.2)];


if length(varargin)
  stru = varargs_to_struct(varargin);
  if isfield(stru,'SpikeHeight')
    space = 1-stru.SpikeHeight;
    
    size(ys)
    size(xs)
    sh = stru.SpikeHeight;
    size(mean(ys,2))
    ys = repmat(mean(ys,1),[2 1]) + repmat([sh/2; -sh/2],[1 size(ys,2)]);
    size(ys)
    varargin = struct_to_varargs(rmfield(stru,'SpikeHeight'));
  end
  if isfield(stru,'SpikeOffset')
    offset = stru.SpikeOffset;
    varargin = struct_to_varargs(rmfield(stru,'SpikeOffset'));
  else
    offset = 0;
  end
  
  
  hs = line(xs,ys+offset,'Color','k','LineWidth',2,varargin{:});
else
  hs = line(xs,ys,'Color','k');
end

axis tight
