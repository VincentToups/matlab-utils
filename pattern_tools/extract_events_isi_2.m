function [events,fid] = extract_events_isi_2(spikes,thresh,filtn,dt,minspikes)
%
%
%


if ~exist('minspikes')
  minspikes = 5;
end

s=spikes(:,:,1);
times=sort(s(s>0));
isi = diff(times);

if ~exist('filtn')
    filtn = round(size(spikes,1)*.05); 
end

if not(mod(filtn,2)) 
  filtn = filtn -1; 
end
if filtn<=0
  filtn =1;
end
%filtn = 1;

isi = filter(ones([1 filtn])/filtn,1,isi);
fid = isi;
shift = - (filtn+1)/2;

if ~exist('dt')
  dt = 1;
end

mx = max(isi);
if isempty(mx)
  events = [];
  fids = [];
  return;
end
mx = mx(1);
if isempty(thresh)
  dd = diff(spikes,1,2);
  dd = dd(dd>0);
  if ~isempty(dd)
    thresh = .25*min(dd);
  else
    thresh = mean(isi);
  end
  thresh
else
  thresh = thresh*mx;
  thresh
  mx
end
thresh
mx
large_isis = isi>thresh;
small_isis = isi<=thresh;

% find first small isi, which marks start of event.
rest_times = times;
rest_large = large_isis;
rest_small = small_isis;
brackets = [];
while ~isempty(rest_times)
  [bracket, rest_times, rest_large, rest_small] = ...
      isi_find_event(rest_times,rest_large,rest_small,shift);
  bracket = bracket(:)';
  brackets = [brackets; bracket];
end
tt = brackets;
nt = size(spikes,1);
leftovers = spikes;
ei = 1;
for bi=1:size(tt,1)
  bracket = sort(tt(bi,:));
  ss = section(spikes,bracket);
  ss = ss(ss>0);
  if length(ss) > minspikes
      events(ei).bracket = bracket;
      events(ei).m = mean(ss);
      events(ei).r = length(ss)/nt;
      events(ei).s = std(ss);
      ei = ei + 1;
  end
end

if ~exist('events')
  events = [];
end

%e%ts = ii(:,1);
%e%close all
%e%rast(spikes);
%e%for t=ts
%e%  line([times(t) times(t)],ylim);
%e%end

