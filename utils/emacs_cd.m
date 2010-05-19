function emacs_cd(d)

sh = envvar('$BUFFER_NAME');
if isempty(sh) || sh(1) == ' '
  sh = '*evalshell*';
end
sh
emacs_eval(['(with-current-buffer (get-buffer "' sh '") (cd "' d '"))']);
