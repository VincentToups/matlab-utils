function ts =make_times(tra,dt,tstart)
%
%

if ~exist('start')
  start = 0;
end

ts = linspace(0,size(tra,2)*dt,size(tra,2));

