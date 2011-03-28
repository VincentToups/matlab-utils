function x=fromTo(m,n)
if ~exist('n')
  x = m(1):m(end);
else
  x = m:n;
end

