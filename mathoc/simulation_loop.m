function hoc__=simulation_loop(n,do_first,do_last)
% HOC__=SIMULATION_LOOP(N)
%

global hoc__

if ~exist('n')
  n = 1;
end

if ~exist('do_first')
  do_first = '\n';
end
if ~exist('do_last')
  do_last = '\n';
end

hoc__ = [hoc__ newline create_simulation_loop(n,do_first,do_last)];
