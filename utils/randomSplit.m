function [a,b]=randomSplit(flatArray)
% Randomly splits flatArray into two sub arrays.
%


if isa(flatArray,'cell')
  add = @(c,item) [c {item}];  
  a = {}; b = {};
else
  add = @(r,item) [r item];
  a = []; b = [];
end

for i=1:length(flatArray)
  item = gix(flatArray,i);
  if rand(1) < .5 
    a = add(a,item);
  else
    b = add(b,item);
  end
end
a = a(:);
b = b(:);