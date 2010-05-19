function varargout=funcall(f,varargin)
varargout{1:nargout} = f(varargin{:});
