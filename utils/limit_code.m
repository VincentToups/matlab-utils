function str=limit_code(a)
%
%

if ~exist('a')
  a = gca;
end

str = [ 'xlim(' to_emacs_string(xlim) ')' newline 'ylim(' to_emacs_string(ylim) ')' newline ];
fprintf(str);
