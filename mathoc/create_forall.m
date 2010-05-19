function str = create_forall(what)
%
%

fns = fieldnames(what);
str = sprintf('forall {');
for fni = 1:length(fns)
  str = [str newline sprintf('    %s = %f', fns{fni}, what.(fns{fni}));]
end
str = [str newline '}' newline];
