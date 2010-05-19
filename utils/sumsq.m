function varargout=sumsq(varargin)
rst = rest(varargin);
varargout{1:nargout} = sum(first(varargin).^2,rst{:});

