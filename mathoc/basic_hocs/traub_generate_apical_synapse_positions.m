function [syns]=traub_generate_apical_synapse_positions(f,n)
%
%
%

traub_shape;

syns.sec = [];
syns.loc = [];
i = 1;
while length(synapse_positions) < n
  sec = randint(length(apical));
  loc = rand(1);
  p = rand(1);
  pat = f(sec,loc);
  if pat < p
    syns(i).sec = sec;
    syns(i).loc = loc;
    i = i + 1;
  end
end
