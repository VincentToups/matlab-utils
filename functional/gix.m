function vs=gix(m,varargin)

if strcmp(class(m),'cell')
  vs = m{varargin{:}};
elseif isnumeric(m)
  vs = m(varargin{:});
elseif isstruct(m)
  if length(varargin) == 1 && ischar(varargin{1})
    vs = m.(varargin{1});
  else
    vs = m(varargin{1});
  end
end
