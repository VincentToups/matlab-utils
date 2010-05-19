function emacs_eval(str,varargin)
% EMACS_INSERT causes text to appear in current emacs buffer
%

str = sprintf(str,varargin{:});
str = strrep(str,'"','\"');
str = sprintf('emacsclient --no-wait --eval "%s" &',str);
system(str);




