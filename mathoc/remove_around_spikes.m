function [outtraces,outtimes]=remove_around_spikes(traces,around,dt,spike_thresh)
% TRACES=REMOVE_AROUND_SPIKES(TRACES,AROUND,DT) removes voltages
% around spike times given the temporal resolution of traces DT and a
% distance AROUND=[BEFORE AFTER], returns a cell array of trials from
% TRACES with voltages around the spikes removed.
%  

if exist('dt')
  around = round(around/dt);
end

if ~exist('spike_thresh')
  spike_thresh = 0.0;
end

if length(around) == 1
  around = [around around];
end

nt = size(traces,1);
ns = size(traces,2);

belowz = traces<spike_thresh;
abovez = traces>spike_thresh;

false = 1==2;
abovez = [abovez(:,2:end) repmat(false, [ nt 1 ])];
crossings = abovez & belowz;

[ii,jj,nothing] = find(crossings);

tf = dt*ns;
t = linspace(0,tf,ns);
make_remove = @(j) (max(1,j-around(1))):(min(ns,j+around(2)));
outtraces = {};
outtimes = {};
for i=1:nt
  trial = traces(i,:);
  tjj = jj(ii==i);
  removeiis = cell2mat(map(make_remove, tjj(:)'));
  trial(removeiis) = [];
  outtraces{i} = trial;
  tt = t;
  tt(removeiis) = [];
  outtimes{i} = tt;
end

