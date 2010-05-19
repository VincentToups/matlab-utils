function emacs_insert_into(buffer,str,varargin)
% EMACS_INSERT causes text to appear in current emacs buffer
%

str = sprintf(str,varargin{:});
str = sprintf('emacsclient --no-wait --eval "(with-current-buffer (get-buffer \\"%s\\") (insert \\"%s\\"))"',buffer,str);
system(str);


