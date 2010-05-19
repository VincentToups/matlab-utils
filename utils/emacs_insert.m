function emacs_insert(str,varargin)
% EMACS_INSERT causes text to appear in current emacs buffer
%

str = sprintf(str,varargin{:});
str = sprintf('emacsclient --no-wait --eval "(insert \\"%s\\")"',str)
system(str);


