function s = emacs_eval(str,varargin)
% EMACS_INSERT causes text to appear in current emacs buffer
%

if ischar(str)
  str = sprintf(str,varargin{:});
  str = strrep(str,'"','\"');
  str = sprintf('emacsclient --no-wait --eval "%s" ',str);
  [nothing, s] = system(str);
  n = str2num(s);
  if ~isempty(n)
    s = n;
  end
elseif iscell(str)
  emacs_eval(cell2emacs(str));
end




