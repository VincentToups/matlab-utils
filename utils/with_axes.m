function varargout=with_axes(a,f,varargin)

push=gca;
varargout{1:nargout} = f(varargin{:});
axes(push);

