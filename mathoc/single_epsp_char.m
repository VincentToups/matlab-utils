function [time,height,width]=single_epsp_char(times,voltage,after)
%
%

if ~exist('after')
  after = 0;
end
voltage = voltage(:)';
times = times(:)';

ii = find(times>after);
times = times(ii);
voltage = voltage(ii);

[height,ii] = max(voltage)
time = times(ii);

hh = mean([height voltage(1)])

vabove = find(voltage>hh)
width = abs(times(vabove(1))-times(vabove(end)));



