function varargout=thickPlot(varargin)
%
%

if length(filt(@(x) isa(x,'char') && strcmp(upper(x),'LINEWIDTH'),...
               varargin))
  varargout{1:nargout} = plot(varargin{:});
else
  varargout{1:nargout} = plot(varargin{:},'LineWidth',2);
end
