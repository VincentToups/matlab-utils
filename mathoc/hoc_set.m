function varargout  = hoc_set(varargin)
%
%

global hoc__
hoc__ = [hoc__ newline...
         create_hoc_set(varargin{:})];
if nargout >= 1
  varargout{1} = hoc__;
end
