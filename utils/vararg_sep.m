function [stru,var] = vararg_sep(args)
%
%

if length(args)
  if isstruct(first(args))
    stru = first(args);
    var = rest(args);
  else
    stru = struct;
    var = args;
  end
else
  stru = struct;
  var = {};
end
