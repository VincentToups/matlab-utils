function varargout=thickPlot(varargin)
%
%

if nargout>0
  args = ['[' join(map(@(x) sprintf('arg%d',1:nargout),1:nargout),',') '] ='];
else
  args = '';
end

if length(filt(@(x) isa(x,'char') && strcmp(upper(x),'LINEWIDTH'),...
               varargin))
  eval(sprintf('%s plot(varargin{:});',args));

else
  eval(sprintf('%s plot(varargin{:},''LineWidth'',2);',args));
end
for i=1:nargout
  varargout{i} = eval(sprintf('arg%d;',i));
end
if nargout==0
  varargout = {};
end