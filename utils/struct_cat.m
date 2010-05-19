function [s]=struct_cat(s,varargin)
%
%

switch length(varargin)
 case 0
  return;
 case 1
  s2 = varargin{1};
  fn1 = fieldnames(s);
  fn1 = fn1(:)';
  fn2 = fieldnames(s2);
  fn2 = fn2(:)';
  allns = unique([fn1 fn2]);
  for ai=1:length(allns)
    alln=allns{ai};
    if ~isfield(s,alln)
      s(1).(alln) = [];
    end
    if ~isfield(s2,alln)
      s2(1).(alln) = [];
    end
  end
  s = [s s2];
 otherwise 
  s = foldl(@(it,ac) struct_cat(ac,it), s, varargin);
end
