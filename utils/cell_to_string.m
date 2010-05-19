function str=cell_to_string(cello)
%
%

if isempty(cello)
  str = '{}';
else
  str = ['{'];
  for i=1:length(cello)
    str = [ str to_emacs_string(cello{i}) ' '];
  end

  str = [str(1:end-1) '}'];
end
