function ints = randint(interval, shape)
% INTS = RANDINT(INTERVAL, SHAPE)
%  generates INTS in shape SHAPE between INTERVAL(1) and INTERVAL(end)

if ~exist('shape')
  shape = 1;
end

if length(interval) == 1
  n = interval;
  shift = 0;
elseif length(interval) == 2
  n = diff(sort(interval))+1;
  shift = ix(sort(interval),1)-1;
else
  error('INTERVAL must be of length 1 or 2');
end

ints = ceil(n.*rand(shape))+shift;
