function vs=gix(m,varargin)

if strcmp(class(m),'cell')
  vs = m{varargin{:}};
elseif isnumeric(m)
  vs = m(varargin{:});
elseif isstruct(m)
  if length(varargin) == 1 && ischar(varargin{1})
    vs = m.(varargin(1));
  else
    fns = fieldnames(m)
    inds = varargin{1};
    if length(inds)==1
      nm = fns{varargin{:}};
      vs = m.(nm);
    else
      vs = {};
      for ii=1:length(inds)
        ind=inds(ii);
        vs{ii} = m.(fns{ind});
      end
    end
  end
end
