function lst(n)

if ~exist('n')
  n = 20;
else
  n = str2num(n);
end

eval(sprintf('!ls -t | head -n %d',n));

