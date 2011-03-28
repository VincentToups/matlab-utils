function b = insideEmacs()
%%% returns true if we are inside an emacs buffer
%%%

b = 0;
if ~isempty(getenv('INSIDE_EMACS'))
  b = 1;
end
