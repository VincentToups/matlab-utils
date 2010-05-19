function il = inlinef(form,varargin)

if ~exist('form')
  form = '';
end

if length(varargin) == 0
  il = inline(form);
elseif length(varargin) > 0
  if isclass(class({}),varargin{1})
    sprintfargs = varargin{1};
    il = inline(sprintf(form,sprintfargs{:}),varargin{2:end});
  else
    il = inline(form, varargin{:});
  end
end
