function [bracket, rest_times, rest_large, rest_small] = isi_find_event(times,large,small,shift)
%

if ~exist('shift')
  shift = 0;
end

first = find(small);
if isempty(first)
  first = length(times);
  bracket = [times(end) times(end)];
  rest_times = []; rest_large = []; rest_small =[];
  return
end
first = first(1);
first = first + shift;
if first < 1
  first = 1;
end
bracket(1) = times(first);
rest_times = times((first+1):end);
rest_small = small((first+1):end);
rest_large = large((first+1):end);
last = find(large);
if isempty(last)
  last = length(rest_times);
end
last = last(1);
last = last + shift;
if last < 1
  last = 1;
end
bracket(2) = rest_times(last);
rest_small = rest_small((last+1):end);
rest_large = rest_large((last+1):end);
rest_times = rest_times((last+1):end);
