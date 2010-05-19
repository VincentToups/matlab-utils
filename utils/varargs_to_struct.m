function [s]=varargs_to_struct(v)
%
%

v = v(:);
v = reshape(v,[2 length(v)/2]);
s = struct;
for i=1:size(v,2)
  s.(v{1,i}) = v{2,i};
end
