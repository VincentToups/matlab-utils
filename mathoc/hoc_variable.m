function hoc__=hoc_variable(item)
% HOC__=HOC_VARIABLE( )
%
global hoc__

nm = inputname(1);
if isempty(nm)
  hoc__ = [hoc__ newline number_to_hoc_number(item)];
else
  hoc__ = [hoc__ newline number_to_hoc_number(nm,item)];
end

